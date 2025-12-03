<template>
  <div class="admin-page-container">
    <div class="admin-main-card">
      
      <div class="page-header">
        <NuxtLink to="/admin/templates" class="back-link">
          &larr; 返回總覽
        </NuxtLink>
        <h1 class="main-title">
          管理名冊：
          <span class="template-name">
            {{ data?.templateName || `資格 (ID: ${templateId})` }}
          </span>
        </h1>
      </div>

      <div class="filter-bar">
        <div class="search-group">
          <input 
            type="search" 
            v-model="searchQuery" 
            placeholder="搜尋姓名或身分證號...."
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
        <p>名冊載入中...</p>
      </div>

      <div v-else-if="error" class="error-box">
        <p class="error-title">載入失敗</p>
        <p class="error-text">無法取得名冊資料。</p>
        <pre class="error-details">{{ error.message }}</pre>
      </div>

      <div v-else-if="!data || !data.data || data.data.length === 0" class="empty-state">
        <p v-if="debouncedSearch">找不到符合「{{ debouncedSearch }}」的民眾。</p>
        <p v-else>此資格目前沒有任何民眾名冊。</p>
      </div>

      <div v-else>
        <div class="table-container">
          <table class="data-table">
            <thead>
              <tr>
                <th>民眾姓名</th>
                <th>身分證號</th>
                <th>地區</th>
                <th>領取狀態</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="person in data.data" :key="person.personId">
                
                <td data-label="姓名">
                  <strong>{{ person.name }}</strong>
                </td>
                
                <td data-label="身分證號">
                  {{ person.nationalId || 'N/A' }}
                </td>
                
                <td data-label="地區">
                  {{ person.county || '' }}{{ person.district || '' }}
                </td>

                <td data-label="領取狀態">
                  <span 
                    :class="['status-badge', getStatusInfo(person.issuedVc).class]"
                  >
                    {{ getStatusInfo(person.issuedVc).text }}
                  </span>
                </td>
                
                <td data-label="操作">
                  <div class="action-buttons">
                    <button 
                      class="details-button"
                      @click="openDetailModal(person)"
                    >
                      查看詳情
                    </button>
                    <button 
                      class="revoke-button"
                      :disabled="person.issuedVc?.status === 'revoked'"
                      @click="openRevokeModal(person)"
                    >
                      註銷資格
                    </button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <div v-if="data.pagination && data.pagination.totalPages > 1" class="pagination-controls">
          <span class="pagination-text">
            第 {{ data.pagination.currentPage }} / {{ data.pagination.totalPages }} 頁
            (共 {{ data.pagination.total }} 筆)
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

    <PersonDetailModal
      :show="isModalOpen"
      :person="selectedPerson"
      @close="isModalOpen = false"
    />

    <RevokeConfirmModal
      :show="isRevokeModalOpen"
      :person="selectedPersonForRevoke"
      :template-name="data?.templateName || ''"
      :is-loading="isRevoking"
      :error-message="revokeError"
      @close="isRevokeModalOpen = false"
      @confirm-revoke="handleConfirmRevoke"
    />

  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue';
// 匯入 Modal
import PersonDetailModal from '~/components/PersonDetailModal.vue';
import RevokeConfirmModal from '~/components/RevokeConfirmModal.vue';

// 1. 取得路由參數
const route = useRoute();
const router = useRouter(); // 用於更新 URL
const templateId = Array.isArray(route.params.templateId) ? route.params.templateId[0] : route.params.templateId;

// 2. 取得 API Base URL
const config = useRuntimeConfig();
const apiBase = config.public.apiBase;

// 3. 篩選器狀態 (與 URL Query 同步)
const searchQuery = ref((route.query.search as string) || '');
const currentPage = ref(Number(route.query.page) || 1);
const limit = 20; // 每頁筆數

// 4. 防抖動 (Debounce) 邏輯
const debouncedSearch = ref(searchQuery.value);
let debounceTimer: NodeJS.Timeout;

watch(searchQuery, (newVal) => {
  clearTimeout(debounceTimer);
  debounceTimer = setTimeout(() => {
    // 只有在 500ms 停止輸入後，才更新 debouncedSearch
    debouncedSearch.value = newVal;
  }, 500);
});

// 5. 監聽狀態，並使用 router.push 更新 URL (這會觸發 useFetch)
watch([currentPage, debouncedSearch], ([newPage, newSearch], [oldPage, oldSearch]) => {
  const query: any = {};
  
  // 如果是新的搜尋，強制回到第 1 頁
  if (newSearch !== oldSearch) {
    query.page = '1';
    currentPage.value = 1; // (手動同步 ref)
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
  return `/api/v1/admin/templates/${templateId}/persons?${params.toString()}`;
});

// 7. Modal 狀態
// (Modal 1: 詳細資料)
const isModalOpen = ref(false);
const selectedPerson = ref<Person | null>(null);
// (Modal 2: 註銷)
const isRevokeModalOpen = ref(false);
const selectedPersonForRevoke = ref<Person | null>(null);
const isRevoking = ref(false); // 控制 Modal 的 loading
const revokeError = ref<string | null>(null); // 儲存 API 錯誤

// CSRF token 狀態與輔助函式
const csrfToken = ref<string | null>(null);

async function ensureCsrfToken(): Promise<string> {
  if (csrfToken.value) return csrfToken.value;

  const res = await $fetch<{ csrfToken: string }>('/api/csrf-token', {
    method: 'GET',
    credentials: 'include'
  });
  if (!res?.csrfToken) {
    throw new Error('CSRF token 取得失敗');
  }
  csrfToken.value = res.csrfToken;
  return csrfToken.value;
}

function openDetailModal(person: Person) {
  selectedPerson.value = person;
  isModalOpen.value = true;
}

function openRevokeModal(person: Person) {
  selectedPersonForRevoke.value = person;
  isRevokeModalOpen.value = true;
  revokeError.value = null; // 清除上次的錯誤
}


// 8. 型別定義 (匹配 API)
interface IssuedVc {
  status: 'issued' | 'revoked' | 'issuing' | 'expired';
}
interface Person {
  personId: string;
  name: string;
  personalId: string;
  nationalId: string | null;
  county: string | null;
  district: string | null;
  address: string | null;
  phoneNumber: string | null;
  dateOfBirth: string | null;
  emergencyContactName: string | null;
  emergencyContactRelationship: string | null;
  emergencyContactPhone: string | null;
  reviewingAuthority: string | null;
  reviewerName: string | null;
  reviewerPhone: string | null;
  eligibilityStartDate: string | null;
  eligibilityEndDate: string | null;
  
  // (財產欄位)
  personalAnnualIncome: string | null;
  personalMovableAssets: string | null;
  personalRealEstateAssets: string | null;
  familyAnnualIncome: string | null;
  familyMovableAssets: string | null;
  familyRealEstateAssets: string | null;

  issuedVc: IssuedVc | null;
}
interface ApiResponse {
  templateName: string; 
  pagination: {
    total: number;
    totalPages: number;
    currentPage: number;
    limit: number;
  };
  data: Person[];
}

// 9. 呼叫 API (BE-2) (取得 refresh)
const { data, pending, error, refresh } = await useFetch<ApiResponse>(apiUrl, {
  method: 'GET',
  lazy: true,
  server: false, 
  default: () => ({ 
    templateName: "載入中...", 
    pagination: { total: 0, totalPages: 0, currentPage: 1, limit: 20 }, 
    data: [] 
  })
});

// 10. (FE-3) 註銷 API 呼叫
async function handleConfirmRevoke(payload: { reason: string }) {
  if (!selectedPersonForRevoke.value) return;

  isRevoking.value = true;
  revokeError.value = null;

  try {
    // 呼叫 BE-3 API
    const url = `/api/v1/admin/eligibility/revoke`;
    const csrf = await ensureCsrfToken();
    await $fetch(url, {
      method: 'POST',
      credentials: 'include',
      body: {
        personId: selectedPersonForRevoke.value.personId,
        templateId: Number(templateId), // 確保是 Number
        reason: payload.reason || null, // 如果是空字串，傳送 null
        csrfToken: csrf
      }
    });

    // 成功
    isRevokeModalOpen.value = false;
    
    // 重新整理 (Refetch) 表格資料
    await refresh();

  } catch (err: any) {
    // 失敗
    console.error("註銷資格失敗:", err);
    // 將 API 錯誤訊息顯示在 Modal 內
    revokeError.value = err.response?._data?.message || '註銷時發生未預期的錯誤。';

  } finally {
    isRevoking.value = false;
  }
}

// 11. 設定頁面標題
useHead({
  title: computed(() => `管理：${data.value?.templateName || `資格 (ID: ${templateId})`}`)
});

// --- 輔助函式 ---

// 12. 狀態顯示輔助
function getStatusInfo(issuedVc: IssuedVc | null) {
  if (!issuedVc) {
    return { text: '⚠️ 未領取', class: 'pending' };
  }
  switch (issuedVc.status) {
    case 'issued':
      return { text: '✅ 已領取', class: 'issued' };
    case 'revoked':
      return { text: '❌ 已註銷', class: 'revoked' };
    default:
      // 處理 'issuing', 'expired' 等其他狀態
      return { text: `⏳ ${issuedVc.status}`, class: 'pending' };
  }
}

// 13. 分頁輔助
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
  max-width: 64rem;
  margin: 0 auto;
  padding: 1.5rem 2rem;
  border-radius: .75rem;
  box-shadow: 0 10px 15px -3px rgba(0,0,0,.1), 0 4px 6px -2px rgba(0,0,0,.05);
}

/* --- 標題 --- */
.page-header {
  margin-bottom: 1rem;
  border-bottom: 1px solid #e2e8f0;
  padding-bottom: 1rem;
}
.back-link {
  font-size: .875rem;
  color: #4299e1;
  text-decoration: none;
  font-weight: 600;
  display: inline-block;
  margin-bottom: .5rem;
  &:hover { text-decoration: underline; }
}
.main-title {
  font-size: 1.875rem;
  font-weight: 700;
  color: #2d3748;
}
.template-name { color: #4299e1; }

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

/* --- 表格內的狀態/按鈕 --- */
.status-badge {
  display: inline-block;
  padding: .25rem .75rem;
  font-weight: 600;
  border-radius: 99px;
  font-size: .75rem;
  
  &.issued { background-color: #c6f6d5; color: #2f855a; }
  &.revoked { background-color: #fed7d7; color: #9b2c2c; }
  &.pending { background-color: #feebc8; color: #9c4221; }
}

.action-buttons {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap; /* 換行 */
}

.details-button, .revoke-button {
  display: inline-block;
  padding: .5rem 1rem;
  font-size: .875rem;
  font-weight: 600;
  border: none;
  border-radius: .375rem;
  text-decoration: none;
  transition: background-color .2s;
  cursor: pointer;
}

.details-button {
  color: #ffffff;
  background-color: #4299e1; /* 藍色 */
  &:hover { background-color: #3182ce; }
}

.revoke-button {
  color: #ffffff;
  background-color: #c53030; /* 紅色 */
  &:hover { background-color: #9b2c2c; }
  &:disabled {
    background-color: #a0aec0;
    opacity: .7;
    cursor: not-allowed;
  }
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
@media (max-width: 768px) {
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
  }
  .action-buttons {
    flex-grow: 1;
    justify-content: flex-end;
  }
}
</style>