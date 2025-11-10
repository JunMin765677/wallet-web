<template>
  <div class="vs2">
    <template v-if="verificationDetails.type === 'single'">
      <div v-if="!verificationResult || verificationResult.status === 'initiated'">
        <p class="subtitle">步驟 2：請民眾掃描 QR Code</p>

        <div class="layout-stack">
          <section class="card context">
            <h3 class="card-title">本次驗證資訊</h3>
            <div class="meta">
              <div class="chip" :class="{ danger: isExpired }" v-if="countdown">
                <template v-if="isExpired">
                  <strong>QR Code 已過期</strong>
                </template>
                <template v-else>
                  <span>將於</span><strong class="mono">{{ countdown }}</strong><span>後失效</span>
                </template>
              </div>
            </div>
            <ul class="kv">
              <li><span>角色</span><strong>{{ verificationDetails.role }}</strong></li>
              <li><span>單位</span><strong>{{ verificationDetails.verifier }}</strong></li>
              <li><span>目的</span><strong>{{ verificationDetails.reason }}</strong></li>
              <li v-if="verificationDetails.notes"><span>備註</span><strong>{{ verificationDetails.notes }}</strong></li>
            </ul>
          </section>

          <section class="card qr-wrap">
            <h3 class="card-title">掃描 QR Code</h3>
            <div class="qr-box">
              <img
                :src="verificationDetails.qrCode"
                alt="Verification QR Code"
                class="qr"
                :class="{ expired: isExpired }"
              />
            </div>
            <div class="status" v-if="!isExpired">
              <span class="status-text">{{ verificationResult?.message || '等待民眾 App 回應…' }}</span>
            </div>
            <div class="actions">
              <button
                @click="emit('cancel-verification')"
                class="btn ghost"
                :disabled="isLoading"
              >
                {{ isExpired ? '返回' : '取消並返回' }}
              </button>
            </div>
          </section>
        </div>
      </div>

      <div v-else>
        <section 
          v-if="verificationResult.status !== 'success'"
          class="card result" 
          :class="getResultStatusClass(verificationResult.status)"
        >
          <span class="icon">
            <component :is="statusIcon(verificationResult.status)" />
          </span>
          <h3 class="result-title">{{ getResultStatusTitle(verificationResult.status) }}</h3>
          <p class="result-msg">{{ verificationResult.message || '流程已結束。' }}</p>
        </section>

        <VerificationResultDetail
          v-if="verificationResult.status === 'success' && verificationResult.verificationData"
          :verificationData="verificationResult.verificationData"
        />

        <div class="page-actions">
          <button
            @click="emit('cancel-verification')"
            class="btn primary"
            :disabled="isLoading"
          >
            返回
          </button>
        </div>
      </div>
    </template>

    <template v-else-if="verificationDetails.type === 'batch'">
      <p class="subtitle">步驟 2：批次驗證（可重複掃描）</p>

      <div class="layout-stack">
        <section class="card context">
          <h3 class="card-title">本次批次資訊</h3>
            <div class="meta">
              <div class="chip" :class="{ danger: isExpired }" v-if="countdown">
                 <template v-if="isExpired">
                  <strong>此批次已過期</strong>
                </template>
                <template v-else>
                  <span>此批次將於</span><strong class="mono">{{ countdown }}</strong><span>後失效</span>
                </template>
              </div>
            </div>
            <ul class="kv">
              <li><span>角色</span><strong>{{ verificationDetails.role }}</strong></li>
              <li><span>單位</span><strong>{{ verificationDetails.verifier }}</strong></li>
              <li><span>目的</span><strong>{{ verificationDetails.reason }}</strong></li>
              <li v-if="verificationDetails.notes"><span>備註</span><strong>{{ verificationDetails.notes }}</strong></li>
              <li v-if="verificationDetails.batchSessionUuid">
                <span>批次識別</span><strong class="mono">{{ verificationDetails.batchSessionUuid }}</strong>
              </li>
            </ul>
        </section>

        <section class="card qr-wrap">
          <h3 class="card-title">請使用其他 QR Code 掃描器</h3>
          <div class="qr-box">
            <img
              :src="verificationDetails.qrCode"
              alt="Verification QR Code"
              class="qr"
              :class="{ expired: isExpired }"
            />
          </div>
          <BatchResultList :results="batchResults" class="mt" />
          <div class="actions">
            <button @click="emit('cancel-verification')" class="btn ghost" :disabled="isLoading">
              {{ isExpired ? '返回' : '結束批次並返回' }}
            </button>
          </div>
        </section>
      </div>
    </template>
  </div>
</template>

<script setup lang="ts">
// (Script 區塊完全不變)
import { computed, h } from 'vue'
import BatchResultList from '~/components/BatchResultList.vue'
import VerificationResultDetail from '~/components/VerificationResultDetail.vue'

/* Props */
const props = defineProps<{
  isLoading: boolean
  verificationDetails: {
    type: 'single' | 'batch'
    qrCode: string
    role: string
    verifier: string
    reason: string
    notes: string
    verificationMode?: string
    expiresAt?: string
    transactionId?: string
    batchSessionUuid?: string
  }
  verificationResult: any | null
  batchResults: any[]
  countdown: string | null
}>()

/* Emits */
const emit = defineEmits<{ (e: 'cancel-verification'): void }>()

/* 過期狀態 */
const isExpired = computed(() => props.countdown === '已過期')

/* 狀態 → 視覺樣式 */
function getResultStatusClass(status: string) {
  switch (status) {
    case 'success': return 'is-success'
    case 'failed':
    case 'expired':
    case 'error_missing_uuid':
    case 'poll_error': return 'is-error'
    default: return 'is-pending'
  }
}

/* 狀態 → Icon (SVG 元件) */
function statusIcon(status: string) {
  if (status === 'success') {
    return {
      render: () =>
        h('svg', { viewBox: '0 0 24 24', 'aria-hidden': 'true', class: 'svgi ok' }, [
          h('path', { d: 'M9 12.75L11.25 15 15 9.75', fill: 'none', stroke: 'currentColor', 'stroke-width': '2', 'stroke-linecap': 'round', 'stroke-linejoin': 'round' }),
          h('circle', { cx: '12', cy: '12', r: '9', fill: 'none', stroke: 'currentColor', 'stroke-width': '2', opacity: '.35' })
        ])
    }
  }
  if (status === 'failed' || status === 'expired' || status === 'poll_error') {
    return {
      render: () =>
        h('svg', { viewBox: '0 0 24 24', 'aria-hidden': 'true', class: 'svgi err' }, [
          h('path', { d: 'M15 9l-6 6M9 9l6 6', fill: 'none', stroke: 'currentColor', 'stroke-width': '2', 'stroke-linecap': 'round', 'stroke-linejoin': 'round' }),
          h('circle', { cx: '12', cy: '12', r: '9', fill: 'none', stroke: 'currentColor', 'stroke-width': '2', opacity: '.35' })
        ])
    }
  }
  return {
    render: () =>
      h('svg', { viewBox: '0 0 24 24', 'aria-hidden': 'true', class: 'svgi wait spin' }, [
        h('circle', { cx: '12', cy: '12', r: '9', fill: 'none', stroke: 'currentColor', 'stroke-width': '3', opacity: '.25' }),
        h('path', { d: 'M21 12a9 9 0 0 0-9-9', fill: 'none', stroke: 'currentColor', 'stroke-width': '3', 'stroke-linecap': 'round' })
      ])
  }
}

/* 標題字串 */
function getResultStatusTitle(status: string) {
  switch (status) {
    case 'success': return '驗證成功'
    case 'failed': return '驗證失敗'
    case 'expired': return '流程已過期'
    case 'error_missing_uuid': return '驗證異常'
    case 'poll_error': return '輪詢錯誤'
    default: return '處理中'
  }
}

/* ---------- 備援：資料正規化 ---------- */
type VerificationData = {
  person: { name: string; nationalId: string }
  contact: {
    emergencyContactName: string
    emergencyContactRelationship: string
    emergencyContactPhone: string
  }
  reviewer: {
    reviewingAuthority: string
    reviewerName: string
    reviewerPhone: string
  }
  verifiedCredentials: Array<{
    templateName: string
    benefitLevel: string
    cardImageUrl: string
  }>
}
function normalizeVerificationData(result: any): VerificationData | null {
  if (!result || (result.status !== 'success' && !result.verificationData) ) return null

  // API v3 (最新)
  if (result.verificationData) {
    return result.verificationData as VerificationData
  }
  
  // API v2 (備援)
  const personSrc = result.person ?? result.subject ?? {}
  const person = {
    name: personSrc.name ?? personSrc.fullName ?? '',
    nationalId: personSrc.nationalId ?? personSrc.idNumber ?? personSrc.id_card_number ?? ''
  }
  const contactSrc = result.contact ?? result.emergencyContact ?? {}
  const contact = {
    emergencyContactName: contactSrc.name ?? contactSrc.emergencyContactName ?? '',
    emergencyContactRelationship: contactSrc.relationship ?? contactSrc.emergencyContactRelationship ?? '',
    emergencyContactPhone: contactSrc.phone ?? contactSrc.emergencyContactPhone ?? ''
  }
  const reviewerSrc = result.reviewer ?? result.audit ?? {}
  const reviewer = {
    reviewingAuthority: reviewerSrc.reviewingAuthority ?? reviewerSrc.org ?? reviewerSrc.organization ?? '',
    reviewerName: reviewerSrc.reviewerName ?? reviewerSrc.name ?? '',
    reviewerPhone: reviewerSrc.reviewerPhone ?? reviewerSrc.phone ?? ''
  }
  let vc: VerificationData['verifiedCredentials'] = []
  if (Array.isArray(result.verifiedCredentials)) {
    vc = result.verifiedCredentials.map((c: any) => ({
      templateName: c.templateName ?? c.name ?? c.type ?? 'Credential',
      benefitLevel: c.benefitLevel ?? c.level ?? '',
      cardImageUrl: c.cardImageUrl ?? c.card ?? c.imageUrl ?? ''
    }))
  }

  return { person, contact, reviewer, verifiedCredentials: vc }
}
const normalizedVerificationData = computed<VerificationData | null>(() =>
  normalizeVerificationData(props.verificationResult)
)
</script>

<style lang="scss" scoped>
/* (樣式不變) */
.vs2 { --radius:.75rem; --gap:1rem; --line:#e2e8f0; --ink:#2d3748; --muted:#718096; --ok:#276749; --err:#9b2c2c; --pri:#3ea86a; --ghost:#a0aec0; }
.subtitle{font-size:1rem;color:#718096;text-align:center;margin-bottom:1.25rem;border-bottom:1px solid var(--line);padding-bottom:.75rem}
.layout-stack{display:grid;gap:var(--gap);grid-template-columns:1fr !important;}
@media (min-width: 960px){.layout-stack{grid-template-columns:1fr !important;}}
.card{background:#fff;border:1px solid var(--line);border-radius:var(--radius);box-shadow:0 6px 18px rgba(0,0,0,.04);}
.card-title{margin:0;padding:.9rem 1rem;font-weight:800;color:var(--ink);border-bottom:1px solid var(--line);background:#fafcff;}
.context .kv{list-style:none;margin:0;padding:0;}
.context .kv li{display:flex;justify-content:space-between;gap:.75rem;padding:.85rem 1rem;font-size:.95rem;border-bottom:1px solid var(--line);}
.context .kv li:last-child{border-bottom:0}
.context .kv span{color:var(--muted);flex-shrink:0}
.context .kv strong{color:var(--ink);word-break:break-all;text-align:right}
.context .mono{font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono","Courier New", monospace;}
.meta{padding:.75rem 1rem 0}
.meta .chip{display:inline-flex;align-items:center;gap:.5rem;padding:.4rem .7rem;border-radius:2rem;font-size:.875rem;font-weight:700;background:#f7fafc;border:1px solid var(--line);color:#4a5568;margin-bottom:.5rem;}
.meta .chip svg{width:1rem;height:1rem;color:#718096;stroke:currentColor;fill:none}
.meta .chip .mono{font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono","Courier New", monospace;}
.meta .chip.danger{background:#fff5f5;border-color:#fed7d7;color:var(--err)}
.qr-wrap{padding:1rem}
.qr-box{display:flex;justify-content:center;align-items:center;padding:.5rem;}
.qr{width:260px;height:260px;max-width:100%;border-radius:.5rem;border:1px solid var(--line);box-shadow:0 8px 20px rgba(0,0,0,.06);transition:filter .2s ease, opacity .2s ease;background:#fff;}
.qr.expired{filter:grayscale(100%);opacity:.55}
.status{margin:.75rem auto 0;display:flex;align-items:center;justify-content:center;gap:.5rem;padding:.65rem .9rem;border-radius:.5rem;background:#f8fafc;border:1px dashed var(--line);}
.status .spin{width:18px;height:18px}
.status .status-text{font-weight:700;color:#744210}
.actions{display:flex;justify-content:center;padding:1rem}
.page-actions{display:flex;justify-content:center;margin-top:1rem}
.btn{appearance:none;border:none;cursor:pointer;padding:.6rem 1.1rem;border-radius:.55rem;font-weight:800;transition:transform .06s ease, box-shadow .2s ease, background .2s ease, opacity .2s ease;}
.btn:active{transform:translateY(1px)}
.btn.primary{background:#48bb78;color:#fff}
.btn.primary:hover{background:var(--pri)}
.btn.ghost{background:var(--ghost);color:#fff}
.btn.ghost:hover{background:#718096}
.btn:disabled{opacity:.55;cursor:not-allowed}
.result{padding:1.25rem;text-align:center;margin-top:.5rem}
.result.is-success{background:#f0fff4;border-color:#9ae6b4}
.result.is-error{background:#fff5f5;border-color:#fed7d7}
.result.is-pending{background:#f8fafc;border-color:#e2e8f0}
.icon{display:inline-flex;margin-bottom:.3rem}
.svgi{width:44px;height:44px}
.svgi.ok{color:var(--ok)}
.svgi.err{color:var(--err)}
.svgi.wait{color:#856404}
.spin{animation:spin 1s linear infinite}
@keyframes spin{to{transform:rotate(360deg)}}
.result-title{font-size:1.25rem;font-weight:800;color:#2d3748;margin:.25rem 0}
.result-msg{font-size:.95rem;color:#4a5568}
.mt { margin-top: 1rem; }
@media (max-width: 480px){.result-title{font-size:1.15rem}.result-msg{font-size:.9rem}}
</style>