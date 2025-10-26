<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRuntimeConfig } from 'nuxt/app'

const config = useRuntimeConfig()
const api = config.public.apiBase

// 定義驗證紀錄的型別
type VerificationHistory = {
  transactionId: string
  ref: string
  status: 'CREATED' | 'COMPLETED' | 'TIMEOUT'
  createdAt: string
  verifyResult: boolean | null
  receivedAt: string | null
}

const history = ref<VerificationHistory[]>([])
const loading = ref(true)
const errorMsg = ref<string | null>(null)

// 從後端 API 取得所有紀錄
async function fetchHistory() {
  loading.value = true
  errorMsg.value = null
  try {
    const data = await $fetch<VerificationHistory[]>(`${api}/verifier/history`)
    history.value = data
  } catch (e: any) {
    errorMsg.value = e?.data?.message || e.message || '讀取驗證紀錄失敗'
  } finally {
    loading.value = false
  }
}

// 輔助函式：格式化日期時間
function formatDate(dateString: string | null) {
  if (!dateString) return '-'
  return new Date(dateString).toLocaleString('zh-TW', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
  })
}

// 輔助函式：顯示狀態文字
function getStatusText(status: string) {
  const map: Record<string, string> = {
    CREATED: '已建立',
    COMPLETED: '已完成',
    TIMEOUT: '已逾時',
  }
  return map[status] || status
}

// 元件載入時自動抓取資料
onMounted(fetchHistory)
</script>

<template>
  <section>
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
      <h1>驗證紀錄</h1>
      <button @click="fetchHistory" :disabled="loading">
        {{ loading ? '更新中...' : '重新整理' }}
      </button>
    </div>
    
    <p v-if="errorMsg" style="color:#b33; margin-bottom: 12px;">{{ errorMsg }}</p>

    <div v-if="loading && !history.length">
      <p>讀取中...</p>
    </div>

    <table v-else-if="history.length > 0" class="history-table">
      <thead>
        <tr>
          <th>狀態</th>
          <th>驗證結果</th>
          <th>服務代碼 (ref)</th>
          <th>建立時間</th>
          <th>完成時間</th>
          <th>Transaction ID</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="item in history" :key="item.transactionId">
          <td>
            <span :class="['status-badge', item.status.toLowerCase()]">
              {{ getStatusText(item.status) }}
            </span>
          </td>
          <td>
            <span v-if="item.verifyResult === true" class="result-badge pass">通過</span>
            <span v-else-if="item.verifyResult === false" class="result-badge fail">未通過</span>
            <span v-else style="color: #999;">-</span>
          </td>
          <td><code>{{ item.ref }}</code></td>
          <td>{{ formatDate(item.createdAt) }}</td>
          <td>{{ formatDate(item.receivedAt) }}</td>
          <td><code>{{ item.transactionId.substring(0, 18) }}...</code></td>
        </tr>
      </tbody>
    </table>
    
    <div v-else>
      <p>目前沒有任何驗證紀錄。</p>
    </div>
  </section>
</template>

<style scoped>
.history-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 14px;
}
.history-table th, .history-table td {
  border: 1px solid #eee;
  padding: 10px 12px;
  text-align: left;
  vertical-align: middle;
}
.history-table th {
  background-color: #f8f9fa;
  font-weight: 600;
}
.status-badge, .result-badge {
  padding: 4px 8px;
  border-radius: 999px;
  font-size: 12px;
  font-weight: 700;
  color: white;
  white-space: nowrap;
}
.status-badge.created { background-color: #17a2b8; }
.status-badge.completed { background-color: #28a745; }
.status-badge.timeout { background-color: #ffc107; color: #333; }

.result-badge.pass { background-color: #28a745; }
.result-badge.fail { background-color: #dc3545; }

code {
  font-family: 'Courier New', Courier, monospace;
  font-size: 13px;
  background-color: #f1f1f1;
  padding: 2px 4px;
  border-radius: 4px;
}
</style>
