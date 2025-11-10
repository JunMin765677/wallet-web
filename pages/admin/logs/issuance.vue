<template>
  <div class="admin-page-container">
    <div class="admin-main-card">
      
      <h1 class="main-title">簽發總日誌</h1>
      <p class="subtitle">
        依時間倒序顯示所有憑證申領事件的稽核軌跡。
      </p>

      <div v-if="pending" class="loading-state">
        <svg class="animate-spin h-8 w-8 text-blue-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
          <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
          <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
        </svg>
        <p>日誌載入中...</p>
      </div>

      <div v-else-if="error" class="error-box">
        <p class="error-title">載入失敗</p>
        <p class="error-text">無法取得簽發日誌資料。</p>
        <pre class="error-details">{{ error.message }}</pre>
      </div>

      <div v-else-if="!data || !data.data || data.data.length === 0" class="empty-state">
        <p>目前沒有任何簽發日誌。</p>
      </div>

      <div v-else>
        <div class="table-container">
          <table class="data-table">
            <thead>
              <tr>
                <th>申領時間</th>
                <th>福利種類</th>
                <th>民眾</th>
                <th>地區</th>
                <th>申領狀態 (Log)</th>
                <th>憑證狀態 (VC)</th>
                <th>System UUID</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="log in data.data" :key="log.id">
                
                <td data-label="申領時間" class="nowrap">
                  {{ formatDateTime(log.createdAt) }}
                </td>

                <td data-label="福利種類">
                  <div class="template-cell-content">
                    <img
                      v-if="log.issuedVC.template.cardImageUrl"
                      :src="log.issuedVC.template.cardImageUrl"
                      :alt="log.issuedVC.template.templateName"
                      class="card-thumbnail"
                    />
                    <div v-else class="card-placeholder">
                      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 15.75l5.159-5.159a2.25 2.25 0 013.182 0l5.159 5.159m-1.5-1.5l1.409-1.409a2.25 2.25 0 013.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 001.5-1.5V6a1.5 1.5 0 00-1.5-1.5H3.75A1.5 1.5 0 002.25 6v12a1.5 1.5 0 001.5 1.5zm10.5-11.25h.008v.008h-.008V8.25zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
                      </svg>
                    </div>
                    <strong>{{ log.issuedVC.template.templateName }}</strong>
                  </div>
                </td>
                
                <td data-label="民眾">
                  {{ log.issuedVC.person.name }}
                </td>

                <td data-label="地區">
                  {{ log.issuedVC.person.county || '' }}
                  {{ log.issuedVC.person.district || '' }}
                </td>

                <td data-label="申領狀態">
                  <span 
                    :class="['status-badge', getLogStatusInfo(log.status).class]"
                  >
                    {{ getLogStatusInfo(log.status).text }}
                  </span>
                </td>

                <td data-label="憑證狀態">
                   <span 
                    :class="['status-badge', getVcStatusInfo(log.issuedVC.status).class]"
                  >
                    {{ getVcStatusInfo(log.issuedVC.status).text }}
                  </span>
                </td>
                
                <td data-label="System UUID" class="uuid-cell">
                  {{ log.issuedVC.systemUuid }}
                </td>
                
              </tr>
            </tbody>
          </table>
        </div>

        <div v-if="data.pagination && data.pagination.totalPages > 1" class="pagination-controls">
          <span class="pagination-text">
            第 {{ data.pagination.currentPage }} / {{ data.pagination.totalPages }} 頁
            (共 {{ data.pagination.totalItems }} 筆)
          </span>
          <div class="pagination-buttons">
            <button @click="goToPage(1)" :disabled="!hasPrevPage" title="第一頁">
              «
            </button>
            <button @click="goToPage(currentPage - 1)" :disabled="!hasPrevPage" title="上一頁">
              ‹
            </button>
            <button @click="goToPage(currentPage + 1)" :disabled="!hasNextPage" title="下一頁">
              ›
            </button>
            <button @click="goToPage(data.pagination.totalPages)" :disabled="!hasNextPage" title="最末頁">
              »
            </button>
          </div>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue';

// 1. 取得路由/Config
const route = useRoute();
const router = useRouter(); // 用於更新 URL
const config = useRuntimeConfig();
const apiBase = config.public.apiBase;

// 2. 頁面標題
useHead({
  title: '簽發總日誌 - 後台管理'
});

// 3. 篩選器狀態 (僅分頁)
const currentPage = ref(Number(route.query.page) || 1);
const limit = 20;

// 4. 監聽狀態，並使用 router.push 更新 URL (這會觸發 useFetch)
watch(currentPage, (newPage) => {
  router.push({ query: { page: newPage.toString() } });
});

// 5. 響應式 API URL
// (它會自動監聽 route.query 的變化)
const apiUrl = computed(() => {
  const params = new URLSearchParams();
  params.set('page', (route.query.page as string) || '1');
  params.set('limit', limit.toString());
  return `/api/v1/admin/logs/issuance?${params.toString()}`;
});

// 6. 型別定義 (匹配 API)
interface LogPerson {
  name: string;
  county: string | null;
  district: string | null;
}
interface LogTemplate {
  templateName: string;
  cardImageUrl: string | null;
}
interface LogIssuedVC {
  status: string;
  systemUuid: string;
  person: LogPerson;
  template: LogTemplate;
}
interface IssuanceLog {
  id: string;
  status: 'user_claimed' | 'expired' | 'initiated';
  createdAt: string;
  issuedVC: LogIssuedVC;
}
interface ApiResponse {
  pagination: {
    totalItems: number;
    totalPages: number;
    currentPage: number;
    limit: number;
  };
  data: IssuanceLog[];
}

// 7. 呼叫 API (BE-1)
const { data, pending, error } = await useFetch<ApiResponse>(apiUrl, {
  method: 'GET',
  lazy: true,
  server: false, 
  default: () => ({ 
    pagination: { totalItems: 0, totalPages: 0, currentPage: 1, limit: 20 }, 
    data: [] 
  })
});

// --- 輔助函式 ---

// 8. 申領狀態 (Log)
function getLogStatusInfo(status: string) {
  switch (status) {
    case 'user_claimed':
      return { text: '✅ 成功', class: 'issued' };
    case 'expired':
      return { text: '⌛️ 過期', class: 'revoked' };
    case 'initiated':
    default:
      return { text: '⏳ 處理中', class: 'pending' };
  }
}

// 9. 憑證狀態 (VC) [⭐️ UPDATED]
function getVcStatusInfo(status: string) {
  switch (status) {
    case 'issued':
      return { text: '已發行', class: 'issued' }; // (範例 1)
    case 'revoked':
      return { text: '已註銷', class: 'revoked' }; // (範例 2)
    case 'expired':
      return { text: '未領取 (過期)', class: 'revoked' }; // (範例 3)
    case 'issuing':
    default:
      return { text: '發行中', class: 'pending' }; // (範例 4)
  }
}

// 10. 日期格式化
function formatDateTime(dateString: string | null) {
  if (!dateString) return 'N/A';
  try {
    return new Date(dateString).toLocaleString('zh-TW', {
      year: 'numeric',
      month: '2-digit',
      day: '2-digit',
      hour: '2-digit',
      minute: '2-digit'
    });
  } catch (e) {
    return '無效日期';
  }
}

// 11. 分頁輔助
const hasPrevPage = computed(() => {
  return (data.value?.pagination.currentPage || 1) > 1;
});
const hasNextPage = computed(() => {
  const pag = data.value?.pagination;
  if (!pag) return false;
  return pag.currentPage < pag.totalPages;
});

function goToPage(page: number) {
  const total = data.value?.pagination.totalPages || 1;
  if (page < 1) page = 1;
  if (page > total) page = total;
  currentPage.value = page;
}
</script>

<style lang="scss" scoped>
/* --- 基礎佈局 --- */
// .admin-page-container {
//   background-color: #f7fafc;
//   min-height: 100vh;
//   padding: 1.5rem;
// }
.admin-main-card {
  background-color: #ffffff;
  width: 100%;
  max-width: 80rem; /* 日誌頁面可以非常寬 */
  margin: 0 auto;
  padding: 1.5rem 2rem;
  border-radius: .75rem;
  box-shadow: 0 10px 15px -3px rgba(0,0,0,.1), 0 4px 6px -2px rgba(0,0,0,.05);
}
.main-title {
  font-size: 1.875rem;
  font-weight: 700;
  color: #2d3748;
  margin-bottom: .5rem;
}
.subtitle {
  font-size: 1rem;
  color: #718096;
  margin-bottom: 2rem;
  border-bottom: 1px solid #e2e8f0;
  padding-bottom: 1rem;
}

/* --- 狀態顯示 --- */
.loading-state, .empty-state {
  text-align: center;
  padding: 4rem 1rem;
  font-size: 1rem;
  color: #718096;
  background-color: #f7fafc;
  border: 1px dashed #e2e8f0;
  border-radius: .5rem;
  .animate-spin { margin: 0 auto 1rem auto; width: 2.5rem; height: 2.5rem; color: #4299e1; }
}
.error-box {
  padding: 1rem;
  background-color: #fff5f5;
  border: 1px solid #fc8181;
  border-radius: .375rem;
  color: #c53030;
  .error-title { font-size: 1rem; font-weight: 600; }
  .error-text { font-size: .875rem; }
  .error-details { font-size: .75rem; color: #e53e3e; margin-top: .5rem; white-space: pre-wrap; word-break: break-all; }
}

/* --- 卡片縮圖 --- */
.template-cell-content {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}
.card-thumbnail {
  width: 64px;
  height: 40px;
  object-fit: cover;
  border-radius: 4px;
  border: 1px solid #e2e8f0;
  background-color: #f7fafc;
  flex-shrink: 0;
}
.card-placeholder {
  width: 64px;
  height: 40px;
  border-radius: 4px;
  background-color: #f7fafc;
  border: 1px dashed #cbd5e0;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #cbd5e0;
  flex-shrink: 0;
  svg { width: 1.5rem; height: 1.5rem; }
}

/* --- 表格 --- */
.table-container { overflow-x: auto; }
.data-table {
  width: 100%;
  min-width: 1000px; /* 確保寬表格在小螢幕上可滾動 */
  border-collapse: collapse;
  text-align: left;
  font-size: .875rem;
  
  thead {
    background-color: #f7fafc;
    border-bottom: 2px solid #e2e8f0;
    th { padding: .75rem 1rem; font-weight: 600; color: #4a5568; }
  }
  tbody {
    tr {
      border-bottom: 1px solid #e2e8f0;
      &:nth-child(even) { background-color: #f7fafc; }
      &:hover { background-color: #ebf8ff; }
    }
    td {
      padding: 1rem;
      color: #2d3748;
      vertical-align: middle;
      strong { color: #1a202c; font-weight: 600; }
    }
  }
}

/* --- 表格內的狀態/欄位 --- */
.status-badge {
  display: inline-block;
  padding: .25rem .75rem;
  font-weight: 600;
  border-radius: 99px;
  font-size: .75rem;
  
  &.issued { background-color: #c6f6d5; color: #2f855a; } /* 綠 */
  &.revoked { background-color: #fed7d7; color: #9b2c2c; } /* 紅 */
  &.pending { background-color: #feebc8; color: #9c4221; } /* 黃 */
}

.nowrap {
  white-space: nowrap;
}
.uuid-cell {
  font-family: monospace;
  font-size: .8rem;
  color: #718096;
  max-width: 150px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* --- 分頁 --- */
.pagination-controls {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  gap: 1rem;
  margin-top: 1.5rem;
  padding-top: 1rem;
  border-top: 1px solid #e2e8f0;
  @media (min-width: 640px) { flex-direction: row; }
}
.pagination-text {
  font-size: .875rem;
  font-weight: 500;
  color: #718096;
}
.pagination-buttons {
  display: flex;
  gap: 0.5rem;
  button {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 2.5rem;
    height: 2.5rem;
    padding: 0;
    font-size: 1rem;
    font-weight: 600;
    color: #4299e1;
    background-color: #ffffff;
    border: 1px solid #cbd5e0;
    border-radius: .375rem;
    cursor: pointer;
    &:hover { background-color: #ebf8ff; border-color: #4299e1; }
    &:disabled { color: #cbd5e0; background-color: #f7fafc; cursor: not-allowed; }
  }
}


/* --- 響應式 (RWD) 表格 --- */
@media (max-width: 1024px) {
  .data-table {
    thead { display: none; }
    tr {
      display: block;
      margin-bottom: 1.5rem;
      border: 1px solid #e2e8f0;
      border-radius: .5rem;
      box-shadow: 0 1px 3px 0 rgba(0,0,0,.1);
      &:nth-child(even) { background-color: #ffffff; }
    }
    td {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: .75rem 1rem;
      border-bottom: 1px solid #e2e8f0;
      &::before {
        content: attr(data-label);
        font-weight: 600;
        color: #718096;
        padding-right: 1rem;
        flex-shrink: 0;
      }
      &:last-child { border-bottom: none; }
    }
    .template-cell-content {
      justify-content: flex-end;
      flex-grow: 1;
      strong {
        white-space: normal;
        text-align: right;
      }
    }
    .uuid-cell {
      max-width: none;
      white-space: normal;
      word-break: break-all;
    }
  }
}
</style>