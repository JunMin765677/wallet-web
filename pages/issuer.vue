<script setup lang="ts">
import { ref, computed, onUnmounted } from 'vue'
import { useRuntimeConfig } from 'nuxt/app'

const config = useRuntimeConfig()
const api = config.public.apiBase

type IssueResult = {
  transactionId?: string
  qrCode?: string
  deepLink?: string
  cid?: string
  issuedAt?: string
  status?: 'ISSUED' | 'REVOKED'
} | null

/** 共同狀態 */
const loading = ref(false)
const errorMsg = ref<string | null>(null)
const successMsg = ref<string | null>(null)
const result = ref<IssueResult>(null)

/** 輪詢相關狀態 */
const isPolling = ref(false)
const pollingIntervalId = ref<NodeJS.Timeout | null>(null)
const pollingTimedOut = ref(false)

const disabled = computed(() => loading.value || isPolling.value)

/** 表單狀態 */
const vcUid = ref('00000000_staff')
const name = ref('')

function resetMessages() {
  errorMsg.value = null
  successMsg.value = null
}

/** 停止輪詢 */
function stopPolling() {
  if (pollingIntervalId.value) {
    clearInterval(pollingIntervalId.value)
    pollingIntervalId.value = null
  }
  isPolling.value = false
}

/** 開始輪詢以取得 CID */
function startPollingForCid(transactionId: string) {
  stopPolling() // 先停止任何可能在執行的輪詢
  isPolling.value = true
  pollingTimedOut.value = false
  successMsg.value = 'QR 已產生，正自動為您查詢 CID... (最長等待 2 分鐘)'
  errorMsg.value = null

  const startTime = Date.now()
  const twoMinutes = 2 * 60 * 1000

  pollingIntervalId.value = setInterval(async () => {
    // 檢查是否超時
    if (Date.now() - startTime > twoMinutes) {
      stopPolling()
      pollingTimedOut.value = true
      errorMsg.value = '查詢 CID 超時，您可以稍後手動重試。'
      return
    }

    try {
      // 嘗試取得憑證
      const out = await $fetch<{transactionId:string; cid:string; issuedAt:string}>(`${api}/issuer/credential/${transactionId}`)
      if (out.cid) {
        stopPolling()
        result.value = { ...result.value, cid: out.cid, issuedAt: out.issuedAt, status: 'ISSUED' }
        successMsg.value = '成功取得憑證 CID！'
      }
    } catch (e) {
      // 預期中的錯誤 (使用者尚未掃描)，不顯示錯誤訊息，繼續輪詢
      console.log('Polling for CID, not ready yet...')
    }
  }, 5000) // 每 5 秒輪詢一次
}

async function createQrWithData() {
  resetMessages()
  stopPolling()
  result.value = null
  pollingTimedOut.value = false

  if (!vcUid.value) { errorMsg.value = '請選擇 vcUid'; return }
  if (!name.value) { errorMsg.value = '請輸入 name'; return }

  loading.value = true
  try {
    const out = await $fetch<{transactionId:string; qrCode:string; deepLink:string}>(`${api}/issuer/qrcode/data`, {
      method: 'POST',
      body: { vcUid: vcUid.value, name: name.value },
    })
    result.value = out
    // 成功後開始輪詢
    startPollingForCid(out.transactionId)
  } catch (e: any) {
    errorMsg.value = e?.data?.message || e.message || '發生錯誤'
  } finally {
    loading.value = false
  }
}

async function revokeCredential() {
  if (!result.value?.cid) return
  resetMessages()
  loading.value = true
  try {
    const out = await $fetch<{ cid:string; credentialStatus:string; updatedRows:number }>(
      `${api}/issuer/credential/${encodeURIComponent(result.value.cid)}/revocation`,
      { method: 'PUT' }
    )
    result.value = { ...result.value, status: 'REVOKED' }
    successMsg.value = `憑證已撤銷（${out.credentialStatus}）`
  } catch (e: any) {
    errorMsg.value = e?.data?.message || e.message || '撤銷失敗'
  } finally {
    loading.value = false
  }
}

function copy(text?: string) {
  if (!text) return
  navigator.clipboard?.writeText(text)
  successMsg.value = '已複製到剪貼簿'
}

// 元件銷毀時確保停止輪詢，避免記憶體洩漏
onUnmounted(() => {
  stopPolling()
})
</script>

<template>
  <section>
    <h1 style="font-size:28px;font-weight:700;margin-bottom:8px;">簽發 Demo</h1>
    <p style="color:#666;margin-bottom:16px;">本流程支援查憑證（取得 CID）與撤銷</p>

    <!-- 表單 -->
    <div style="border:1px solid #eee;border-radius:12px;padding:16px;margin-bottom:16px;">
      <h3 style="margin-bottom:12px;">輸入憑證資料</h3>
      <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;margin-bottom:12px;">
        <select v-model="vcUid" :disabled="disabled" style="background-color: white;">
          <option value="00000000_staff">員工證</option>
        </select>
        <input v-model="name" :disabled="disabled" placeholder="name（姓名）" />
      </div>
      <button :disabled="disabled" @click="createQrWithData">產生 QR</button>
    </div>

    <!-- 訊息 -->
    <p v-if="errorMsg" style="color:#b33;margin-bottom:12px;">{{ errorMsg }}</p>
    <p v-if="successMsg" style="color:#2d7a46;margin-bottom:12px;">{{ successMsg }}</p>

    <!-- 結果區 -->
    <div v-if="result" style="border:1px solid #eee;border-radius:12px;padding:16px;">
      <p><b>transactionId：</b>
        <code>{{ result.transactionId }}</code>
        <button @click="copy(result.transactionId)" style="margin-left:8px;padding:2px 8px;border:1px solid #ddd;border-radius:6px;background-color:#f8f9fa;color:#333;">複製</button>
      </p>
      
      <!-- 輪詢狀態 -->
      <div v-if="isPolling" style="display: flex; align-items: center; gap: 8px; margin: 12px 0; color: #007bff;">
        <svg width="24" height="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><rect class="spinner_Gu6E" x="1" y="1" width="7.3" height="7.3"/><rect class="spinner_Gu6E spinner_f9ol" x="1" y="15.7" width="7.3" height="7.3"/><rect class="spinner_Gu6E spinner_CVyV" x="15.7" y="15.7" width="7.3" height="7.3"/><rect class="spinner_Gu6E spinner_47sM" x="15.7" y="1" width="7.3" height="7.3"/></svg>
        <span>查詢 CID 中...</span>
      </div>

      <div v-if="result.qrCode" style="margin:12px 0;">
        <img :src="result.qrCode" alt="QR" style="width:240px;height:240px;object-fit:contain;border:1px solid #f0f0f0;border-radius:8px;" />
      </div>

      <div v-if="result.deepLink" style="margin-bottom:12px;">
        <a :href="result.deepLink" style="text-decoration:underline;">在錢包 App 開啟（deep link）</a>
      </div>

      <!-- 憑證操作區 -->
      <div style="display:flex;flex-wrap:wrap;gap:8px;align-items:center;">
        <!-- 超時後顯示手動重試按鈕 -->
        <button v-if="pollingTimedOut && !result.cid" @click="startPollingForCid(result.transactionId!)">
          重試查詢
        </button>

        <span v-if="result.cid">
          <b>CID：</b> <code>{{ result.cid }}</code>
          <button @click="copy(result.cid)" style="margin-left:8px;padding:2px 8px;border:1px solid #ddd;border-radius:6px;background-color:#f8f9fa;color:#333;">複製</button>
        </span>

        <span v-if="result.issuedAt">（issuedAt: {{ result.issuedAt }}）</span>

        <!-- 狀態徽章 -->
        <span v-if="result.status" :style="{
          padding:'2px 8px', border:'1px solid',
          borderColor: result.status==='REVOKED' ? '#b33' : '#2d7a46',
          color: result.status==='REVOKED' ? '#b33' : '#2d7a46',
          borderRadius:'999px', marginLeft:'8px'
        }">
          {{ result.status }}
        </span>

        <!-- 撤銷按鈕 -->
        <button v-if="result.cid && result.status !== 'REVOKED'"
                :disabled="disabled"
                @click="revokeCredential"
                style="background-color:#dc3545;">
          撤銷憑證
        </button>
      </div>
    </div>
  </section>
</template>

<style scoped>
.spinner_Gu6E {
  animation: spinner_55GR 2.4s linear infinite;
}
.spinner_f9ol {
  animation-delay: -0.6s;
}
.spinner_CVyV {
  animation-delay: -1.2s;
}
.spinner_47sM {
  animation-delay: -1.8s;
}
@keyframes spinner_55GR {
  0%, 50% {
    width: 7.3px;
    height: 7.3px;
  }
  25% {
    width: 2.4px;
    height: 2.4px;
  }
}
</style>

