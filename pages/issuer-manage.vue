<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRuntimeConfig } from 'nuxt/app'

const config = useRuntimeConfig()
const api = config.public.apiBase

// 定義憑證資料的型別
type Credential = {
  cid: string
  status: 'ISSUED' | 'REVOKED'
  issuedAt: string
  revokedAt: string | null
  name: string
  vcUid: string
  transactionId: string
  verificationCount: number
  lastVerifiedAt: string | null
}

const credentials = ref<Credential[]>([])
const loading = ref(true)
const errorMsg = ref<string | null>(null)

// 用於撤銷確認的 Modal 狀態
const showConfirmModal = ref(false)
const credentialToRevoke = ref<Credential | null>(null)
const isRevoking = ref(false)

// 從後端 API 取得所有憑證
async function fetchCredentials() {
  loading.value = true
  errorMsg.value = null
  try {
    const data = await $fetch<Credential[]>(`${api}/issuer/credentials`)
    credentials.value = data
  } catch (e: any) {
    errorMsg.value = e?.data?.message || e.message || '讀取憑證列表失敗'
  } finally {
    loading.value = false
  }
}

// 點擊撤銷按鈕時，顯示確認視窗
function handleRevokeClick(cred: Credential) {
  credentialToRevoke.value = cred
  showConfirmModal.value = true
}

// 確認執行撤銷動作
async function confirmRevoke() {
  if (!credentialToRevoke.value) return
  isRevoking.value = true
  errorMsg.value = null

  try {
    await $fetch(`${api}/issuer/credential/${encodeURIComponent(credentialToRevoke.value.cid)}/revocation`, {
      method: 'PUT'
    })
    
    // 直接更新前端本地的狀態，讓畫面即時反應
    const credInList = credentials.value.find(c => c.cid === credentialToRevoke.value!.cid)
    if (credInList) {
      credInList.status = 'REVOKED'
      credInList.revokedAt = new Date().toISOString()
    }
  } catch (e: any) {
    errorMsg.value = `撤銷失敗：${e?.data?.message || e.message}`
  } finally {
    isRevoking.value = false
    showConfirmModal.value = false
    credentialToRevoke.value = null
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

// 元件載入時自動抓取資料
onMounted(fetchCredentials)
</script>

<template>
  <section>
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
      <h1>簽發管理</h1>
      <button @click="fetchCredentials" :disabled="loading">
        {{ loading ? '更新中...' : '重新整理' }}
      </button>
    </div>
    
    <p v-if="errorMsg" style="color:#b33; margin-bottom: 12px;">{{ errorMsg }}</p>

    <div v-if="loading && !credentials.length">
      <p>讀取中...</p>
    </div>

    <table v-else-if="credentials.length > 0" class="credential-table">
      <thead>
        <tr>
          <th>狀態</th>
          <th>姓名</th>
          <th>CID (前12碼)</th>
          <th>簽發時間</th>
          <th>撤銷時間</th>
          <th>驗證次數</th>
          <th>上次驗證時間</th>
          <th>操作</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="cred in credentials" :key="cred.cid">
          <td>
            <span :class="['status-badge', cred.status.toLowerCase()]">
              {{ cred.status }}
            </span>
          </td>
          <td>{{ cred.name }}</td>
          <td><code>{{ cred.cid.substring(0, 12) }}...</code></td>
          <td>{{ formatDate(cred.issuedAt) }}</td>
          <td>{{ formatDate(cred.revokedAt) }}</td>
          <td>{{ cred.verificationCount }}</td>
          <td>{{ formatDate(cred.lastVerifiedAt) }}</td>
          <td>
            <button
              v-if="cred.status === 'ISSUED'"
              @click="handleRevokeClick(cred)"
              class="revoke-button"
            >
              撤銷
            </button>
            <span v-else style="color: #999;">-</span>
          </td>
        </tr>
      </tbody>
    </table>
    
    <div v-else>
      <p>目前沒有任何已簽發的憑證。</p>
    </div>

    <!-- 撤銷確認 Modal -->
    <div v-if="showConfirmModal" class="modal-overlay">
      <div class="modal-content">
        <h3>確認撤銷憑證</h3>
        <p>您確定要撤銷此憑證嗎？此操作無法復原。</p>
        <div v-if="credentialToRevoke" style="background-color: #f8f9fa; padding: 8px; border-radius: 4px; margin-top: 12px;">
          <strong>姓名:</strong> {{ credentialToRevoke.name }}<br>
          <strong>CID:</strong> <code style="word-break: break-all;">{{ credentialToRevoke.cid }}</code>
        </div>
        <div class="modal-actions">
          <button @click="showConfirmModal = false" :disabled="isRevoking">取消</button>
          <button @click="confirmRevoke" class="revoke-button-confirm" :disabled="isRevoking">
            {{ isRevoking ? '撤銷中...' : '確認撤銷' }}
          </button>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.credential-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 14px;
}
.credential-table th, .credential-table td {
  border: 1px solid #eee;
  padding: 10px 12px;
  text-align: left;
  vertical-align: middle;
}
.credential-table th {
  background-color: #f8f9fa;
  font-weight: 600;
}
.status-badge {
  padding: 4px 8px;
  border-radius: 999px;
  font-size: 12px;
  font-weight: 700;
  text-transform: uppercase;
  color: white;
  white-space: nowrap;
}
.status-badge.issued {
  background-color: #28a745;
}
.status-badge.revoked {
  background-color: #dc3545;
}
.revoke-button {
  background-color: transparent;
  color: #dc3545;
  border: 1px solid #dc3545;
}
.revoke-button:hover {
  background-color: #dc3545;
  color: white;
}
.revoke-button-confirm {
   background-color: #dc3545;
   color: white;
}
code {
  font-family: 'Courier New', Courier, monospace;
  font-size: 13px;
}
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}
.modal-content {
  background: white;
  padding: 24px;
  border-radius: 8px;
  width: 90%;
  max-width: 400px;
  box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}
.modal-actions {
  margin-top: 24px;
  display: flex;
  justify-content: flex-end;
  gap: 12px;
}
</style>

