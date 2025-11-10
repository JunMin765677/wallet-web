<template>
  <div class="admin-page-container">
    <div class="admin-main-card">
      
      <h1 class="main-title">驗證總日誌 (表3)</h1>
      <p class="subtitle">
        稽核所有已發生的驗證事件。
      </p>

      <div class="filter-bar">
        <div class="search-group">
          <input 
            type="search" 
            v-model="searchQuery" 
            placeholder="搜尋機構、目的、民眾姓名、福利身份..."
            class="search-input"
          />
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z" />
          </svg>
        </div>
      </div>

      <div v-if="pending" class="loading-state">
        <svg class="animate-spin h-8 w-8 text-blue-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
          <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
          <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
        </svg>
        <p>日誌載入中...</p>
      </div>

      <div v-else-if="error" class="error-box">
        <p class="error-title">載入失敗</p>
        <p class="error-text">無法取得驗證日誌資料。</p>
        <pre class="error-details">{{ error.message }}</pre>
      </div>

      <div v-else-if="!data || !data.data || data.data.length === 0" class="empty-state">
        <p v-if="debouncedSearch">找不到符合「{{ debouncedSearch }}」的日誌。</p>
        <p v-else>目前沒有任何驗證日誌。</p>
      </div>

      <div v-else>
        <div class="table-container">
          <table class="data-table">
            <thead>
              <tr>
                <th>驗證時間 (B.1)</th>
                <th>福利身份 (B.9)</th>
                <th>結果 (B.8)</th>
                <th>驗證機構 (B.2)</th>
                <th>機構類別 (B.3)</th>
                <th>驗證目的 (B.4)</th>
                <th>驗證民眾 (B.6)</th>
                <th>民眾地區 (B.7)</th>
                <th>備註 (B.5)</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="log in data.data" :key="log.id">
                
                <td data-label="驗證時間" class="nowrap">
                  {{ formatDateTime(log.verifiedAt) }}
                </td>

                <td data-label="福利身份">
                  <div v-if="log.verifiedIdentities.length > 0" class="tag-list">
                    <span v-for="id in log.verifiedIdentities" :key="id" class="tag">
                      {{ id }}
                    </span>
                  </div>
                  <span v-else class="text-muted">無</span>
                </td>
                
                <td data-label="結果">
                  <span :class="['status-badge', getResultStatus(log.result).class]">
                    {{ getResultStatus(log.result).text }}
                  </span>
                </td>


                <td data-label="驗證機構">
                  <strong>{{ log.agencyName || 'N/A' }}</strong>
                </td>
                
                <td data-label="機構類別">
                  {{ log.agencyType || 'N/A' }}
                </td>

                <td data-label="驗證目的">
                  {{ log.purpose || 'N/A' }}
                </td>

                <td data-label="驗證民眾">
                  {{ log.personName || 'N/A' }}
                </td>

                <td data-label="民眾地區">
                  {{ log.personArea || 'N/A' }}
                </td>


                <td data-label="備註" class="notes-cell">
                  {{ log.notes || 'N/A' }}
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
  title: '驗證總日誌 - 後台管理'
});

// 3. 篩選器狀態 (與 URL Query 同步)
const searchQuery = ref((route.query.search as string) || '');
const currentPage = ref(Number(route.query.page) || 1);
const limit = 20;

// 4. 防抖動 (Debounce) 邏輯
const debouncedSearch = ref(searchQuery.value);
let debounceTimer: NodeJS.Timeout;

watch(searchQuery, (newVal) => {
  clearTimeout(debounceTimer);
  debounceTimer = setTimeout(() => {
    debouncedSearch.value = newVal;
  }, 500); // 500ms
});

// 5. 監聽狀態，並使用 router.push 更新 URL (這會觸發 useFetch)
watch([currentPage, debouncedSearch], ([newPage, newSearch], [oldPage, oldSearch]) => {
  const query: any = {};
  
  if (newSearch !== oldSearch) {
    query.page = '1';
    currentPage.value = 1; 
  } else {
    query.page = newPage.toString();
  }
  
  if (newSearch) {
    query.search = newSearch;
  }
  
  router.push({ query });
});


// 6. 響應式 API URL
// (它會自動監聽 route.query 的變化)
const apiUrl = computed(() => {
  const params = new URLSearchParams();
  params.set('page', (route.query.page as string) || '1');
  params.set('limit', limit.toString());
  if (route.query.search) {
    params.set('search', route.query.search as string);
  }
  return `/api/v1/admin/logs/verification?${params.toString()}`;
});

// 7. 型別定義 (匹配 API)
interface VerificationLog {
  id: string;
  verifiedAt: string;
  agencyName: string | null;
  agencyType: string | null;
  purpose: string | null;
  notes: string | null;
  personName: string | null;
  personArea: string | null;
  result: boolean | null;
  verifiedIdentities: string[];
}
interface ApiResponse {
  pagination: {
    totalItems: number;
    totalPages: number;
    currentPage: number;
    limit: number;
  };
  data: VerificationLog[];
}

// 8. 呼叫 API (BE-1)
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

// 9. 狀態顯示輔助 (result: true/false)
function getResultStatus(result: boolean | null) {
  if (result === true) {
    return { text: '✅ 成功', class: 'issued' };
  }
  if (result === false) {
    return { text: '❌ 失敗', class: 'revoked' };
  }
  // (處理 null 或其他情況)
  return { text: 'N/A', class: 'pending' };
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

/* --- 篩選器 (Search) --- */
.filter-bar { margin-bottom: 1.5rem; }
.search-group {
  position: relative;
  max-width: 400px;
  .search-input {
    display: block;
    width: 100%;
    padding: .75rem 1rem;
    padding-left: 2.75rem; 
    font-size: 1rem;
    color: #2d3748;
    background-color: #ffffff;
    border: 1px solid #cbd5e0;
    border-radius: .375rem;
    box-shadow: 0 1px 2px 0 rgba(0,0,0,.05);
    &:focus {
      outline: none;
      border-color: #4299e1;
      box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.5);
    }
  }
  svg {
    position: absolute;
    left: 0.75rem;
    top: 50%;
    transform: translateY(-50%);
    width: 1.25rem;
    height: 1.25rem;
    color: #a0aec0;
    pointer-events: none;
  }
}

/* --- 狀態 (Loading, Error, Empty) --- */
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

/* --- 表格 --- */
.table-container { overflow-x: auto; }
.data-table {
  width: 100%;
  min-width: 1200px; /* 確保寬表格在小螢幕上可滾動 */
  border-collapse: collapse;
  text-align: left;
  font-size: .875rem;
  
  thead {
    background-color: #f7fafc;
    border-bottom: 2px solid #e2e8f0;
    th { padding: .75rem 1rem; font-weight: 600; color: #4a5568; white-space: nowrap; }
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
.nowrap {
  white-space: nowrap;
}
.text-muted {
  color: #a0aec0;
}
.status-badge {
  display: inline-block;
  padding: .25rem .75rem;
  font-weight: 600;
  border-radius: 99px;
  font-size: .75rem;
  
  &.issued { background-color: #c6f6d5; color: #2f855a; } /* 綠 (成功) */
  &.revoked { background-color: #fed7d7; color: #9b2c2c; } /* 紅 (失敗) */
  &.pending { background-color: #feebc8; color: #9c4221; } /* 黃 (N/A) */
}
.notes-cell {
  max-width: 200px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.tag-list {
  display: flex;
  flex-wrap: wrap;
  gap: 0.25rem;
  max-width: 250px;
}
.tag {
  display: inline-block;
  padding: 0.125rem 0.5rem;
  font-size: .75rem;
  font-weight: 500;
  border-radius: 99px;
  background-color: #e2e8f0;
  color: #4a5568;
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
@media (max-width: 1280px) {
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
    
    .tag-list {
      justify-content: flex-end;
      max-width: 60%;
    }
    .notes-cell {
      max-width: 60%;
      white-space: normal;
      text-align: right;
    }
  }
}
</style>