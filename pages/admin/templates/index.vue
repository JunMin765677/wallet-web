<template>
  <div class="admin-page-container">
    <div class="admin-main-card">
      
      <h1 class="main-title">社福資格總覽</h1>
      <p class="subtitle">
        管理所有福利種類的核發狀態與名冊。
      </p>

      <div v-if="pending" class="loading-state">
        </div>

      <div v-else-if="error" class="error-box">
        </div>

      <div v-else-if="!templates || templates.length === 0" class="empty-state">
        </div>

      <div v-else class="table-container">
        <table class="data-table">
          <thead>
            <tr>
              <th>福利名稱</th>
              <th>總符合資格</th>
              <th>已領取憑證</th>
              <th>待領取 (未啟用)</th>
              <th>操作</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="template in templates" :key="template.id">
              
              <td data-label="福利名稱">
                <div class="template-cell-content">
                  <img
                    v-if="template.cardImageUrl"
                    :src="template.cardImageUrl"
                    :alt="template.templateName"
                    class="card-thumbnail"
                  />
                  <div v-else class="card-placeholder">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 15.75l5.159-5.159a2.25 2.25 0 013.182 0l5.159 5.159m-1.5-1.5l1.409-1.409a2.25 2.25 0 013.182 0l2.909 2.909m-18 3.75h16.5a1.5 1.5 0 001.5-1.5V6a1.5 1.5 0 00-1.5-1.5H3.75A1.5 1.5 0 002.25 6v12a1.5 1.5 0 001.5 1.5zm10.5-11.25h.008v.008h-.008V8.25zm.375 0a.375.375 0 11-.75 0 .375.375 0 01.75 0z" />
                    </svg>
                  </div>
                  <strong>{{ template.templateName }}</strong>
                </div>
              </td>
              
              <td data-label="總符合資格">
                {{ template.stats.totalEligible.toLocaleString() }} 人
              </td>
              
              <td data-label="已領取憑證" class="issued">
                {{ template.stats.totalIssued.toLocaleString() }} 人
              </td>
              
              <td data-label="待領取" class="pending">
                {{ template.stats.totalPending.toLocaleString() }} 人
              </td>
              
              <td data-label="操作">
                <NuxtLink 
                  :to="`/admin/templates/${template.id}`" 
                  class="manage-button"
                >
                  管理名冊
                </NuxtLink>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
// 1. 設定頁面標題
useHead({
  title: '社福資格總覽 - 後台管理'
});

// 2. 定義 API 回應的型別 [⭐️ 修改]
interface TemplateStat {
  id: number;
  templateName: string;
  cardImageUrl: string | null; // [⭐️ 新增]
  stats: {
    totalEligible: number;
    totalIssued: number;
    totalPending: number;
  };
}

// 3. 取得 API Base URL
const config = useRuntimeConfig();
const apiBase = config.public.apiBase;
const url = `/api/v1/admin/templates/stats`;

// 4. 呼叫 API (BE-1) (不變)
const { data: templates, pending, error } = await useFetch<TemplateStat[]>(url, {
  method: 'GET',
  lazy: true,
  server: false, 
  default: () => [] 
});

// 5. (可選) 錯誤處理
if (error.value) {
  console.error("無法載入模板統計資料:", error.value);
}
</script>

<style lang="scss" scoped>
/* --- 基礎佈局 (不變) --- 
.admin-page-container {
  background-color: #f7fafc;
  min-height: 100vh;
  padding: 1.5rem;
}
  */
.admin-main-card {
  background-color: #ffffff;
  width: 100%;
  max-width: 64rem;
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

/* --- 狀態顯示 (不變) --- */
.loading-state, .empty-state {
  text-align: center;
  padding: 4rem 1rem;
  font-size: 1rem;
  color: #718096;
  background-color: #f7fafc;
  border: 1px dashed #e2e8f0;
  border-radius: .5rem;

  .animate-spin {
    margin: 0 auto 1rem auto;
    width: 2.5rem;
    height: 2.5rem;
    color: #4299e1;
  }
}
.error-box {
  padding: 1rem;
  background-color: #fff5f5;
  border: 1px solid #fc8181;
  border-radius: .375rem;
  color: #c53030;
  /* ... (其他錯誤樣式) ... */
}

/* --- [⭐️ NEW] 卡片縮圖樣式 --- */
.template-cell-content {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}
.card-thumbnail {
  width: 64px; /* 64px */
  height: 40px; /* 16:10 比例 */
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
  
  svg {
    width: 1.5rem;
    height: 1.5rem;
  }
}


/* --- 表格樣式 (不變) --- */
.table-container {
  overflow-x: auto;
}
.data-table {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
  font-size: .875rem;
  
  thead {
    background-color: #f7fafc;
    border-bottom: 2px solid #e2e8f0;
    th {
      padding: .75rem 1rem;
      font-weight: 600;
      color: #4a5568;
    }
  }

  tbody {
    tr {
      border-bottom: 1px solid #e2e8f0;
      &:nth-child(even) {
        background-color: #f7fafc;
      }
      &:hover {
        background-color: #ebf8ff;
      }
    }

    td {
      padding: 1rem;
      color: #2d3748;
      vertical-align: middle; /* 確保圖片和文字垂直置中 */

      strong {
        color: #1a202c;
        font-weight: 600;
      }

      &.issued {
        color: #2f855a;
        font-weight: 500;
      }
      &.pending {
        color: #dd6b20;
        font-weight: 500;
      }
    }
  }
}

.manage-button {
  display: inline-block;
  padding: .5rem 1rem;
  font-size: .875rem;
  font-weight: 600;
  color: #ffffff;
  background-color: #4299e1;
  border: none;
  border-radius: .375rem;
  text-decoration: none;
  transition: background-color .2s;

  &:hover {
    background-color: #3182ce;
  }
}

/* --- 響應式 (RWD) 表格 --- */
@media (max-width: 768px) {
  .data-table {
    thead {
      display: none; 
    }
    
    tr {
      display: block;
      margin-bottom: 1.5rem;
      border: 1px solid #e2e8f0;
      border-radius: .5rem;
      box-shadow: 0 1px 3px 0 rgba(0,0,0,.1);
      
      &:nth-child(even) {
        background-color: #ffffff;
      }
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

      /* [⭐️ 修改] 確保 RWD 時，縮圖+文字在右側 */
      .template-cell-content {
        justify-content: flex-end;
        flex-grow: 1;
        /* RWD 時，文字可能需要換行 */
        strong {
          white-space: normal;
          text-align: right;
        }
      }

      &:last-child {
        border-bottom: none;
      }
    }
  }

  .manage-button {
    width: 100%;
    text-align: center;
  }
}
</style>