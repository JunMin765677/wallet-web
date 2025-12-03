<script setup lang="ts">
import { ref, onUnmounted } from 'vue'
import VerifySplash from '~/components/VerifySplash.vue'
import VerifyStep1RoleSelection, { type RoleOption } from '~/components/VerifyStep1RoleSelection.vue'
import VerifyStep1Form from '~/components/VerifyStep1Form.vue'
import VerifyStep2Status from '~/components/VerifyStep2Status.vue'
import Loading from '~/components/Loading.vue'

// 1) 取得 Runtime Config
const config = useRuntimeConfig()
const apiBase = config.public.apiBase

// 2) 頁面標題
useHead({ title: '數位憑證身份驗證' })

// 3) 流程狀態管理
const isInitialized = ref(true)                 // 控制開場 Splash
const isLoggingIn = ref(false)                   // 控制「模擬登入」→ 改由 Loading 動畫決定結束
const selectedRole = ref<RoleOption | null>(null)
const isLoading = ref(false)                     // 控制 API 請求 Loading（表單送出）
const errorMessage = ref<string | null>(null)    // 全域錯誤訊息

const csrfToken = ref<string | null>(null)

async function ensureCsrfToken(): Promise<string> {
  if (csrfToken.value) return csrfToken.value

  const res = await $fetch<{ csrfToken: string }>('/api/csrf-token', {
    method: 'GET',
    credentials: 'include'
  })
  if (!res?.csrfToken) throw new Error('CSRF token 取得失敗')

  csrfToken.value = res.csrfToken
  return csrfToken.value
}

// (型別定義)
type VerificationDetails =
  | ({
      // 來自 Step 12 表單
      role: string
      verifier: string
      reason: string
      notes: string
      verificationMode: string
      // 來自 API 回應
      type: 'single' | 'batch'
      qrCode: string
      expiresAt: string
      deepLink?: string
      transactionId?: string
      batchSessionUuid?: string
    } | null)

// 儲存 API 1 (request-verification) 回應
const verificationDetails = ref<VerificationDetails>(null)

// 4) 輪詢狀態：單次/批次
const verificationResult = ref<any | null>(null)
const pollTimer = ref<NodeJS.Timeout | null>(null)

const batchResults = ref<any[]>([])
const batchPollTimer = ref<NodeJS.Timeout | null>(null)

// 倒數
const countdownDisplay = ref<string | null>(null)
const countdownTimer = ref<NodeJS.Timeout | null>(null)

// 5) 流程：角色選擇 → 進入「模擬登入 Loading」
function handleRoleSelected(role: RoleOption) {
  console.log('[Verifier FE] 角色已選擇:', role.name)
  selectedRole.value = role
  isLoggingIn.value = true          // 進入 Loading 畫面
  errorMessage.value = null
}
// Loading 動畫完成 → 結束「模擬登入」→ 顯示表單
function handleLoginLoadingDone() {
  isLoggingIn.value = false
}

// 6) 流程：送出表單請求驗證
async function handleStartVerification(formData: {
  verificationMode: string
  role: string
  verifier: string
  reason: string
  notes: string
}) {
  isLoading.value = true
  errorMessage.value = null
  console.log('[Verifier FE] 點擊「取得 QRcode」，送出資料:', formData)

  try {
    const url = `/api/verification/request-verification`
    const csrf = await ensureCsrfToken()
    const response = await $fetch<any>(url, {
      method: 'POST',
      credentials: 'include',
      body: {
        ...formData,
        csrfToken: csrf
      }
    })

    if (!response.expiresAt) {
      throw new Error('API 回應格式錯誤: 缺少 "expiresAt" 欄位')
    }

    if (response.type === 'single') {
      verificationDetails.value = { ...formData, ...response }
      console.log('[Verifier FE] 成功取得 [單次] QR Code。 TxID:', response.transactionId)
      startPolling(response.transactionId)      // 啟動單次輪詢
      startCountdown(response.expiresAt)        // 倒數

    } else if (response.type === 'batch') {
      verificationDetails.value = { ...formData, ...response }
      console.log('[Verifier FE] 成功取得 [批次] QR Code。 BatchUUID:', response.batchSessionUuid)
      startBatchPolling(response.batchSessionUuid) // 啟動批次輪詢
      startCountdown(response.expiresAt)

    } else {
      throw new Error('API 回應格式錯誤: 缺少 "type" 欄位')
    }
  } catch (error: any) {
    console.error('[Verifier FE] 請求驗證 API 失敗:', error)
    errorMessage.value = error.response?._data?.message || '請求驗證失敗，請檢查網路連線或稍後再試。'
  } finally {
    isLoading.value = false
  }
}

// 7) (API 1) 單次輪詢
function startPolling(transactionId: string) {
  stopPolling()
  verificationResult.value = { status: 'initiated', message: '使用者尚未出示憑證' }
  console.log(`[Verifier FE] (單次) 開始輪詢 (TxID: ${transactionId})`)

  pollTimer.value = setInterval(async () => {
    if (!verificationDetails.value || verificationDetails.value.type !== 'single') {
      stopPolling()
      return
    }
    console.log(`[Verifier FE] (單次) 正在查詢狀態 (TxID: ${transactionId})...`)
    try {
      const pollUrl = `/api/verification/check-status/${transactionId}`
      const response = await $fetch<any>(pollUrl, { method: 'GET' })
      verificationResult.value = response

      if (response.status !== 'initiated') {
        console.log(`[Verifier FE] (單次) 輪詢結束，最終狀態: ${response.status}`)
        stopPolling()
        stopCountdown()
      }
    } catch (error: any) {
      console.error('[Verifier FE] (單次) 輪詢 API 失敗:', error)
      stopPolling()
      stopCountdown()
      verificationResult.value = {
        status: 'poll_error',
        message: error.response?._data?.message || '輪詢時發生未預期的錯誤，請稍後再試。'
      }
    }
  }, 3000)
}
function stopPolling() {
  if (pollTimer.value) {
    clearInterval(pollTimer.value)
    pollTimer.value = null
    console.log('[Verifier FE] (單次) 停止輪詢。')
  }
}

// 8) (API 2) 批次輪詢
function startBatchPolling(batchUuid: string) {
  stopBatchPolling()
  batchResults.value = []
  console.log(`[Verifier FE] (批次) 開始輪詢 (UUID: ${batchUuid})`)

  batchPollTimer.value = setInterval(async () => {
    if (!verificationDetails.value || verificationDetails.value.type !== 'batch') {
      stopBatchPolling()
      return
    }
    console.log(`[Verifier FE] (批次) 正在查詢狀態 (UUID: ${batchUuid})...`)
    try {
      const pollUrl = `/api/verification/check-batch-status/${batchUuid}`
      const response = await $fetch<any>(pollUrl, { method: 'GET' })

      if (response && response.results) {
        batchResults.value = response.results
      }
      if (response.sessionInfo?.status !== 'active') {
        console.log(`[Verifier FE] (批次) Session 已關閉 (${response.sessionInfo.status})，自動停止輪詢。`)
        stopBatchPolling()
        stopCountdown()
      }
    } catch (error: any) {
      console.error('[Verifier FE] (批次) 輪詢 API 失敗:', error)
      if (error.response?.status >= 404) {
        console.error('[Verifier FE] (批次) 偵測到嚴重錯誤，停止輪詢。')
        stopBatchPolling()
        stopCountdown()
        errorMessage.value = error.response?._data?.message || '批次輪詢時發生嚴重錯誤'
      }
    }
  }, 3000)
}
function stopBatchPolling() {
  if (batchPollTimer.value) {
    clearInterval(batchPollTimer.value)
    batchPollTimer.value = null
    console.log('[Verifier FE] (批次) 停止輪詢。')
  }
}

// 9) 倒數計時
function stopCountdown() {
  if (countdownTimer.value) {
    clearInterval(countdownTimer.value)
    countdownTimer.value = null
    console.log('[Verifier FE] (Countdown) 停止倒數。')
  }
}
function formatTimeDiff(ms: number): string {
  if (ms <= 0) return '00:00'
  let totalSeconds = Math.floor(ms / 1000)
  let hours = Math.floor(totalSeconds / 3600)
  totalSeconds %= 3600
  let minutes = Math.floor(totalSeconds / 60)
  let seconds = totalSeconds % 60
  const pad = (n: number) => n.toString().padStart(2, '0')
  return hours > 0 ? `${pad(hours)}:${pad(minutes)}:${pad(seconds)}` : `${pad(minutes)}:${pad(seconds)}`
}
function startCountdown(expiresAt: string) {
  stopCountdown()
  const expiryTime = new Date(expiresAt).getTime()
  console.log(`[Verifier FE] (Countdown) 開始倒數至 ${expiresAt}`)

  countdownTimer.value = setInterval(() => {
    const now = Date.now()
    const diff = expiryTime - now
    if (diff <= 0) {
      countdownDisplay.value = '已過期'
      stopCountdown()
      if (
        verificationDetails.value?.type === 'single' &&
        (!verificationResult.value || verificationResult.value.status === 'initiated')
      ) {
        console.log('[Verifier FE] (Countdown) 倒數結束，強制設為過期狀態。')
        stopPolling()
        verificationResult.value = { status: 'expired', message: '驗證流程已過期' }
      }
    } else {
      countdownDisplay.value = formatTimeDiff(diff)
    }
  }, 1000)

  const initialDiff = expiryTime - Date.now()
  if (initialDiff <= 0) {
    countdownDisplay.value = '已過期'
    stopCountdown()
  } else {
    countdownDisplay.value = formatTimeDiff(initialDiff)
  }
}

// 10) 導航：返回填表
function goBackToForm() {
  stopPolling()
  stopBatchPolling()
  stopCountdown()
  verificationDetails.value = null
  verificationResult.value = null
  batchResults.value = []
  errorMessage.value = null
  selectedRole.value = null
  countdownDisplay.value = null
}

// 11) 卸載收尾
onUnmounted(() => {
  stopPolling()
  stopBatchPolling()
  stopCountdown()
})
</script>

<template>
  <section class="page soft-surface">
    <div class="narrow">
      <h1 class="main-title fade-slide">暖心e證通 社福憑證身份驗證</h1>

      <VerifyStep1RoleSelection
        v-if="isInitialized && !selectedRole && !isLoggingIn"
        key="role-select"
        class="fade-in"
        :style="{ '--delay': '0.1s' }"
        @role-selected="handleRoleSelected"
      />

      <ClientOnly v-if="isInitialized && isLoggingIn">
        <Loading
          :phrases="[
            '流程準備中',
            '已收到您的登入資料',
            `正在登入 ${selectedRole?.organizationName || '組織'}`,
            '確認此機構具備驗證資格',
            '即將完成',
            '成功'
          ]"
          :scroll-base-speed="0.55"
          :ease-period="320"
          check-active-color="#8fa39d"
          @done="handleLoginLoadingDone"
        />
      </ClientOnly>

      <VerifyStep1Form
        v-if="isInitialized && selectedRole && !isLoggingIn && !verificationDetails"
        key="verify-form"
        class="fade-in"
        :style="{ '--delay': '0.1s' }"
        :is-loading="isLoading"
        :error-message="errorMessage"
        :role-option="selectedRole"
        @submit-verification="handleStartVerification"
        @back-to-roles="selectedRole = null"
      />

      <VerifyStep2Status
        v-if="verificationDetails"
        key="verify-status"
        class="fade-in"
        :style="{ '--delay': '0.1s' }"
        :is-loading="isLoading"
        :verification-details="verificationDetails"
        :verification-result="verificationResult"
        :batch-results="batchResults"
        :countdown="countdownDisplay"
        @cancel-verification="goBackToForm"
      />

      <div v-if="!isLoggingIn && errorMessage" class="error-box fade-in">
        <p class="error-text">{{ errorMessage }}</p>
      </div>

      <p class="footer-note fade-in" :style="{ '--delay': '0.2s' }">
        * 驗證流程將被記錄。請確保您已獲得民眾同意。
      </p>
    </div>
  </section>
</template>

<style scoped>
.page {
  padding: 0.75rem;
  overflow-x: hidden;
  contain: content;
}
.page :where(img, video, canvas, svg) {
  max-width: 100%;
  height: auto;
}
.page * {
  box-sizing: border-box;
}

.narrow {
  max-width: 640px;
  width: 100%;
  margin: 0 auto;
}

/* (註解的 soft-surface 樣式) */

.main-title {
  margin: 0 0 1rem 0;
  font-weight: 800;
  font-size: 1.7rem;
  line-height: 1.25;
  color: #d27b4b;
  text-align: center;
}

.error-box {
  margin-top: 1rem;
  padding: 0.75rem;
  border-radius: 0.75rem;
  background: rgba(241, 99, 99, 0.08);
  border: 1px solid rgba(241, 99, 99, 0.35);
}
.error-text {
  margin: 0;
  font-size: 0.95rem;
  font-weight: 700;
  color: #a61b1b;
  word-break: break-word;
}

.footer-note {
  margin-top: 1.25rem;
  font-size: 0.88rem;
  text-align: center;
  color: #5e6b7a;
}

@media (max-width: 480px) {
  .page { padding: 0.75rem; }
  .narrow { padding: 0 0.25rem; }
  .main-title { font-size: 1.5rem; }
}

/* * 【新增】動畫效果 
 * (與 pages/index.vue 相同)
 */
.fade-in {
  opacity: 0;
  transform: translateY(16px);
  animation: fadeInUp .7s forwards;
  animation-delay: var(--delay, 0s);
}
.fade-slide {
  opacity: 0;
  transform: translateY(-12px);
  animation: fadeSlideDown .8s forwards;
  animation-delay: var(--delay, 0s);
}
@keyframes fadeInUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
@keyframes fadeSlideDown {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>