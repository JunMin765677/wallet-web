<script setup lang="ts">
import { ref, onUnmounted, computed } from 'vue'
import { useRuntimeConfig } from 'nuxt/app'

const config = useRuntimeConfig()
const api = config.public.apiBase

// 輪詢設定
const POLL_INTERVAL_MS = 2500
const TIMEOUT_MS = 2 * 60 * 1000 // 2 分鐘

// 表單&狀態
const refCode = ref('00000000_staff_verifier') // 預設選中
const loading = ref(false)
const errorMsg = ref<string | null>(null)
const successMsg = ref<string | null>(null)

const txId = ref<string | null>(null)
const qrcodeImage = ref<string | null>(null)
const authUri = ref<string | null>(null)

const verifyResult = ref<boolean | null>(null)
const resultDescription = ref<string | null>(null)
const claims = ref<Array<{ credentialType?: string; claims?: any }>>([])

let pollTimer: any = null
const startedAt = ref<number | null>(null)

function resetAll() {
  errorMsg.value = null
  successMsg.value = null
  txId.value = null
  qrcodeImage.value = null
  authUri.value = null
  verifyResult.value = null
  resultDescription.value = null
  claims.value = []
  if (pollTimer) { clearInterval(pollTimer); pollTimer = null }
  startedAt.value = null
}

const elapsedMs = computed(() => startedAt.value ? Date.now() - startedAt.value : 0)
const remainMs = computed(() => Math.max(0, TIMEOUT_MS - elapsedMs.value))
const remainText = computed(() => {
  const s = Math.ceil(remainMs.value / 1000)
  const mm = Math.floor(s / 60).toString().padStart(2, '0')
  const ss = (s % 60).toString().padStart(2, '0')
  return `${mm}:${ss}`
})

function startTimer() {
  startedAt.value = Date.now()
}

function stopPolling() {
  if (pollTimer) { clearInterval(pollTimer); pollTimer = null }
}

function copy(text?: string | null) {
  if (!text) return
  navigator.clipboard?.writeText(text)
  successMsg.value = '已複製到剪貼簿'
}

async function startVerification() {
  resetAll()
  if (!refCode.value) { errorMsg.value = '請選擇驗證服務'; return }
  loading.value = true
  try {
    const out = await $fetch<{ transactionId: string; qrcodeImage: string; authUri: string }>(`${api}/verifier/qrcode`, {
      method: 'POST',
      body: { ref: refCode.value }
    })
    txId.value = out.transactionId
    qrcodeImage.value = out.qrcodeImage
    authUri.value = out.authUri
    successMsg.value = '請用錢包 App 掃描或點開 deep link 出示憑證'
    startTimer()
    // 開始輪詢
    pollTimer = setInterval(pollOnce, POLL_INTERVAL_MS)
  } catch (e: any) {
    errorMsg.value = e?.data?.message || e.message || '發生錯誤'
  } finally {
    loading.value = false
  }
}

type VerifierResult = {
  verifyResult: boolean
  claims: any
  transactionId: string
  resultDescription?: string
}

async function pollOnce() {
  if (!txId.value) return

  // 前端超時保護
  if (startedAt.value && Date.now() - startedAt.value >= TIMEOUT_MS) {
    stopPolling()
    errorMsg.value = '驗證逾時，請重新產生 QR'
    return
  }

  try {
    const resp = await $fetch.raw<VerifierResult>(`${api}/verifier/result`, {
      method: 'POST',
      body: { transactionId: txId.value }
    })

    if (resp.status === 202) {
      // 尚未完成：持續輪詢
      return
    }

    if (resp.status === 200) {
      // 🔒 型別縮窄 + 防呆：_data 可能為 undefined，先檢查
      const out = resp._data
      if (!out) return // 理論上不會，但保險

      verifyResult.value = !!out.verifyResult
      resultDescription.value = out.resultDescription || null
      claims.value = out.claims || []
      successMsg.value = verifyResult.value ? '驗證通過' : '驗證完成'
      stopPolling()
      return
    }

    if (resp.status === 408) {
      const data = resp._data as { message?: string } | undefined
      stopPolling()
      errorMsg.value = data?.message || '驗證逾時，請重新產生 QR'
      return
    }

    // 其它非預期狀態：忽略，繼續輪詢
    return
  } catch (e: any) {
    stopPolling()
    errorMsg.value = e?.data?.message || e.message || '查詢失敗'
  }
}

function restart() {
  resetAll()
}

onUnmounted(() => { stopPolling() })
</script>

<template>
  <section style="max-width:860px;margin:32px auto;font-family:ui-sans-serif,system-ui;">
    <h1 style="font-size:28px;font-weight:700;margin-bottom:8px;">驗證 Demo</h1>
    <p style="color:#666;margin-bottom:16px;">產生驗證 QR → 錢包出示 → 取得 verifyResult 與 claims</p>

    <div style="display:flex;gap:8px;align-items:center;margin-bottom:12px;">
      <select v-model="refCode" style="flex:1;">
        <option value="00000000_staff_verifier">員工證核驗</option>
      </select>
      <button :disabled="loading" @click="startVerification"
              style="padding:10px 14px;border:1px solid #ddd;border-radius:8px;cursor:pointer;">
        產生驗證 QR
      </button>
      <button @click="restart"
              style="padding:10px 12px;border:1px solid #eee;border-radius:8px;cursor:pointer;background:#fafafa;">
        重新開始
      </button>
    </div>

    <p v-if="errorMsg" style="color:#b33;margin-bottom:12px;">{{ errorMsg }}</p>
    <p v-if="successMsg" style="color:#2d7a46;margin-bottom:12px;">{{ successMsg }}</p>

    <div v-if="txId" style="border:1px solid #eee;border-radius:12px;padding:16px;">
      <p>
        <b>transactionId：</b> <code>{{ txId }}</code>
        <button @click="copy(txId)" style="margin-left:8px;padding:2px 8px;border:1px solid #ddd;border-radius:6px;cursor:pointer;">複製</button>
        <span v-if="startedAt" style="margin-left:12px;color:#666;">（剩餘：{{ remainText }}）</span>
      </p>

      <div v-if="qrcodeImage" style="margin:12px 0;">
        <img :src="qrcodeImage" alt="QR" style="width:240px;height:240px;object-fit:contain;border:1px solid #f0f0f0;border-radius:8px;" />
      </div>

      <div v-if="authUri" style="margin-bottom:12px;">
        <a :href="authUri" style="text-decoration:underline;">在錢包 App 開啟（deep link）</a>
      </div>

      <div v-if="verifyResult !== null" style="margin-top:8px;">
        <p>
          <b>verifyResult：</b>
          <span :style="{
            padding:'2px 8px', border:'1px solid',
            borderColor: verifyResult ? '#2d7a46' : '#b33',
            color: verifyResult ? '#2d7a46' : '#b33',
            borderRadius:'999px'
          }">
            {{ verifyResult ? '通過' : '未通過' }}
          </span>
          <span v-if="resultDescription">（{{ resultDescription }}）</span>
        </p>

        <div v-if="Array.isArray(claims) && claims.length" style="margin-top:12px;">
          <h3 style="margin-bottom:8px;">已揭露欄位</h3>
          <div v-for="(c, idx) in claims" :key="idx"
               style="padding:12px;border:1px solid #f2f2f2;border-radius:10px;margin-bottom:8px;">
            <p v-if="c.credentialType" style="margin:0 0 6px 0;"><b>credentialType：</b>{{ c.credentialType }}</p>
            <table v-if="Array.isArray(c.claims)" style="width:100%;border-collapse:collapse;">
              <thead>
                <tr>
                  <th style="text-align:left;border-bottom:1px solid #eee;padding:6px;">ename</th>
                  <th style="text-align:left;border-bottom:1px solid #eee;padding:6px;">cname</th>
                  <th style="text-align:left;border-bottom:1px solid #eee;padding:6px;">value</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(item, j) in c.claims" :key="j">
                  <td style="padding:6px;border-bottom:1px solid #f7f7f7;">{{ item.ename }}</td>
                  <td style="padding:6px;border-bottom:1px solid #f7f7f7;">{{ item.cname }}</td>
                  <td style="padding:6px;border-bottom:1px solid #f7f7f7;">{{ item.value }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <p v-else style="color:#666">等待使用者在錢包 App 出示中…（系統每 {{ POLL_INTERVAL_MS/1000 }} 秒查詢一次）</p>
    </div>
  </section>
</template>

