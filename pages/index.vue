<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted, onActivated, onDeactivated } from 'vue'
import Step1Verification from '~/components/Step1Verification.vue'
import Step2Issuance from '~/components/Step2Issuance.vue'
import Loading from '~/components/Loading.vue'

const config = useRuntimeConfig()
const apiBase = config.public.apiBase

// ======= 三段式狀態 =======
// 'step1' | 'loading' | 'step2'
const view = ref<'step1' | 'loading' | 'step2'>('step1')

// ======= 顯示/資料狀態 =======
const errorMessage = ref<string | null>(null)
const availableTemplates = ref<any[]>([])
const issuanceStatusMap = ref(new Map<string, any>())

// ======= 併發管控（由 loading 主導切換）=======
let opToken = 0                       // 防競態
const apiDone = ref(false)            // API 是否完成
const loadingDone = ref(false)        // Loading 是否完成
let apiTemplatesBuffer: any[] | null = null // 先暫存 API 結果，等 Loading 結束再塞進畫面

function resetAll() {
  errorMessage.value = null
  availableTemplates.value = []
  issuanceStatusMap.value.clear()
  apiDone.value = false
  loadingDone.value = false
  apiTemplatesBuffer = null
}

function goToStep2IfReady() {
  // 只有「Loading 動畫已結束」才允許切換；API 若尚未好，先等
  if (loadingDone.value && apiDone.value) {
    availableTemplates.value = apiTemplatesBuffer || []
    view.value = 'step2'
  }
}

// Loading.vue 動畫結束時呼叫
function handleLoadingDone() {
  loadingDone.value = true
  goToStep2IfReady()
}

// ======= 標題 =======
const pageTitle = computed(() => {
  return view.value === 'step2'
    ? '步驟 2: 申領憑證 - 數位憑證申領'
    : '步驟 1: 身份驗證 - 數位憑證申領'
})
useHead({ title: pageTitle })

// ======= 輪詢（原樣）=======
function stopPolling(templateId: string) {
  const status = issuanceStatusMap.value.get(templateId)
  if (status?.timerId) {
    clearInterval(status.timerId)
    issuanceStatusMap.value.set(templateId, { ...status, timerId: null })
  }
}
function stopAllPolling() {
  for (const id of issuanceStatusMap.value.keys()) stopPolling(id)
}
function startPolling(templateId: string, transactionId: string) {
  stopPolling(templateId)
  const intervalId = setInterval(async () => {
    const current = issuanceStatusMap.value.get(templateId)
    if (!current) {
      clearInterval(intervalId)
      return
    }
    try {
      const pollUrl = `/api/issuance/status/${transactionId}`
      const res = await $fetch<{ status: string; message: string }>(pollUrl, {
        method: 'GET',
        credentials: 'include'
      })
      issuanceStatusMap.value.set(templateId, { ...current, status: res.status, message: res.message })
      if (res.status === 'issued' || res.status === 'expired') {
        stopPolling(templateId)
      }
    } catch (e: any) {
      const cur = issuanceStatusMap.value.get(templateId)
      if (cur) {
        issuanceStatusMap.value.set(templateId, {
          ...cur,
          status: 'error',
          message: e.response?._data?.message || '輪詢時發生未預期的錯誤'
        })
      }
      stopPolling(templateId)
    }
  }, 3000)
  const start = issuanceStatusMap.value.get(templateId)
  if (start) issuanceStatusMap.value.set(templateId, { ...start, timerId: intervalId })
  else clearInterval(intervalId)
}

// ======= 使用流程 =======
async function startMockVerification(method: string) {
  stopAllPolling()
  const token = ++opToken

  // 先收尾 step1 狀態 → 進 loading，由 Loading 決定何時離開
  resetAll()
  view.value = 'loading'
  console.log(`[Issuer FE] 驗證方式: ${method} → 進入 Loading（動畫主導切換）`)

  try {
    // 開始後端請求（與 Loading 並行）
    const url = `/api/issuance/start-simulation`
    const res = await $fetch<{ person: any; availableTemplates: any[] }>(url, {
      method: 'POST',
      credentials: 'include'
    })
    if (token !== opToken) return
    if (!res?.availableTemplates) throw new Error('API 回傳資料不正確')

    // 只標記 API 已完成、並暫存資料；不立刻切 Step2
    apiTemplatesBuffer = res.availableTemplates
    apiDone.value = true
    console.log(`[Issuer FE] API 完成，取得 ${res.availableTemplates.length} 張可申領憑證；等待 Loading 結束後切換`)
    goToStep2IfReady()
  } catch (e: any) {
    if (token !== opToken) return
    errorMessage.value = e.response?._data?.message || '連線至驗證伺服器時發生錯誤，請稍後再試。'
    // 出錯直接回到 step1（也可選擇留在 loading 顯示錯誤）
    view.value = 'step1'
  }
}

async function handleSelectVC(templateId: string) {
  // Step2 內部的 Loading 另計，不影響 Step1→Loading→Step2 的過場
  issuanceStatusMap.value.set(templateId, { status: 'loading' })
  try {
    const url = `/api/issuance/request-credential`
    const res = await $fetch<any>(url, {
      method: 'POST',
      credentials: 'include',
      body: { templateId }
    })
    if (!res?.qrCode || !res?.transactionId) throw new Error('API 回傳資料不完整')
    issuanceStatusMap.value.set(templateId, {
      qrCode: res.qrCode,
      deepLink: res.deepLink,
      transactionId: res.transactionId,
      status: 'initiated',
      message: '等待 App 掃描...',
      timerId: null
    })
    startPolling(templateId, res.transactionId)
  } catch (e: any) {
    issuanceStatusMap.value.set(templateId, {
      status: 'error',
      message: e.response?._data?.message || '申領憑證時發生錯誤，請稍後再試。',
      timerId: null
    })
  }
}

function goBack() {
  stopAllPolling()
  resetAll()
  view.value = 'step1'
}

function handleCancelIssuance(templateId: string) {
  stopPolling(templateId)
  issuanceStatusMap.value.delete(templateId)
  errorMessage.value = null
}

// ======= 生命週期 =======
onMounted(() => {
  document.body.classList.add('modal-page-open')
  stopAllPolling()
  resetAll()
  view.value = 'step1'
})
onActivated(() => {
  document.body.classList.add('modal-page-open')
})
onDeactivated(() => {
  stopAllPolling()
  document.body.classList.remove('modal-page-open')
})
onUnmounted(() => {
  stopAllPolling()
  document.body.classList.remove('modal-page-open')
})
</script>

<template>
  <section class="page soft-surface">
    <div class="narrow">
      <h1 class="main-title fade-slide">暖心e證通 社福憑證申領</h1>

      <Step1Verification
        v-if="view === 'step1'"
        class="fade-in" 
        :style="{ '--delay': '0.1s' }"
        :is-loading="false"
        @start-verification="startMockVerification"
      />

      <ClientOnly v-if="view === 'loading'">
        <Loading
          :phrases="[
            '流程準備中',
            '流程開始',
            '已收到您的登入資料',
            '正在驗證您的身份',
            '正在取得您的社福憑證',
            '回傳中',
            '回傳成功',

          ]"
          :scroll-base-speed="0.55"
          :ease-period="320"
          check-active-color="#8fa39d"
          @done="handleLoadingDone"
        />
      </ClientOnly>

      <Step2Issuance
        v-if="view === 'step2'"
        class="fade-in"
        :style="{ '--delay': '0.1s' }"
        :is-loading="false"
        :available-templates="availableTemplates"
        :issuance-status-map="issuanceStatusMap"
        @select-vc="handleSelectVC"
        @back-to-step1="goBack"
        @cancel-issuance="handleCancelIssuance"
      />

      <div v-if="view !== 'loading' && errorMessage" class="error-box fade-in">
        <p class="error-text">{{ errorMessage }}</p>
      </div>

      <p class="footer-note fade-in" :style="{ '--delay': '0.2s' }">
        * 本服務僅為流程模擬，所有資料均為隨機生成，不會存取您的真實個資。
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
 * (與 admin/index.vue 和 docs/index.vue 相同)
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