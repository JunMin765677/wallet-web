<!-- components/VerifyStep1Form.vue -->
<template>
  <div>
    <!-- Header -->
    <div class="welcome-header">
      <h3 class="welcome-title">
        歡迎： {{ roleOption.organizationName }}
      </h3>
      <p class="welcome-description">
        所屬人員登入暖心 e 憑證驗證系統，請先選擇驗證模式並填寫用途。
      </p>
    </div>

    <form @submit.prevent="handleSubmit" novalidate class="space-y-6">
      <!-- 驗證模式（Radio Group） -->
      <fieldset class="form-group" :aria-invalid="!verificationModeValid ? 'true' : 'false'">
        <legend class="form-label">
          驗證模式 <span class="required-star">*</span>
        </legend>

        <div class="radio-group" role="radiogroup" aria-describedby="modeHelp">
          <label
            class="radio-label"
            :class="{ selected: verificationMode === 'single' }"
          >
            <input
              class="radio-input"
              type="radio"
              name="verificationMode"
              value="single"
              v-model="verificationMode"
              aria-labelledby="modeSingleTitle"
              aria-describedby="modeSingleDesc"
            />
            <svg class="radio-icon" viewBox="0 0 24 24" aria-hidden="true">
              <circle cx="12" cy="12" r="9" fill="none" stroke="currentColor" stroke-width="2"/>
              <circle v-if="verificationMode === 'single'" cx="12" cy="12" r="5" fill="currentColor"/>
            </svg>
            <div class="radio-texts">
              <span id="modeSingleTitle" class="radio-title">單次驗證</span>
              <span id="modeSingleDesc" class="radio-description">
                產生 1 個 QR Code，供 1 位對象掃描；有效 5 分鐘。
              </span>
            </div>
          </label>

          <label
            class="radio-label"
            :class="{ selected: verificationMode === 'batch' }"
          >
            <input
              class="radio-input"
              type="radio"
              name="verificationMode"
              value="batch"
              v-model="verificationMode"
              aria-labelledby="modeBatchTitle"
              aria-describedby="modeBatchDesc"
            />
            <svg class="radio-icon" viewBox="0 0 24 24" aria-hidden="true">
              <rect x="4" y="6" width="16" height="12" rx="3" ry="3" fill="none" stroke="currentColor" stroke-width="2"/>
              <path d="M8 10h8M8 14h8" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
            </svg>
            <div class="radio-texts">
              <span id="modeBatchTitle" class="radio-title">批次驗證</span>
              <span id="modeBatchDesc" class="radio-description">
                產生 1 個可重複使用的 QR Code，供多人掃描；有效 3 小時。
              </span>
            </div>
          </label>
        </div>

        <p id="modeHelp" class="help-text">
          選擇適合的驗證流程；可在下一步查看狀態與倒數時間。
        </p>
      </fieldset>

      <!-- 驗證目的（Select：帶代碼＋說明；不做角色過濾） -->
      <div class="form-group">
        <label for="reason" class="form-label">
          驗證目的為何？ <span class="required-star">*</span>
        </label>

        <div class="select-wrapper">
          <select
            id="reason"
            v-model="form.reasonCode"
            class="form-select"
            :aria-invalid="!reasonValid ? 'true' : 'false'"
            aria-describedby="reasonHelp reasonDesc"
            required
          >
            <option value="" disabled>— 請選擇驗證目的 —</option>
            <option
              v-for="opt in allReasons"
              :key="opt.code"
              :value="opt.code"
              :title="opt.desc"
            >
              {{ opt.label }}
            </option>
          </select>

          <!-- 自訂下拉箭頭 -->
          <svg class="select-caret" viewBox="0 0 24 24" aria-hidden="true">
            <path d="M6 9l6 6 6-6" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
          </svg>
        </div>

        <!-- <p id="reasonHelp" class="help-text">
          若選擇「其他（請於備註說明）」，請在備註欄位補充具體情境。
        </p> -->

        <!-- 選中項目說明 -->
        <p
          v-if="selectedReason"
          id="reasonDesc"
          class="help-text"
          style="margin-top:.25rem"
        >
          用途說明：{{ selectedReason.desc }}
        </p>
      </div>

      <!-- 備註（Textarea + 字數） -->
      <div class="form-group">
        <label for="notes" class="form-label">
          備註（選填）
          <span v-if="form.reasonCode === 'OTHER'" class="badge-required">此欄必填</span>
        </label>

        <div class="textarea-with-counter">
          <textarea
            id="notes"
            v-model="form.notes"
            class="form-textarea"
            :class="{ 'has-error': notesError }"
            :maxlength="NOTES_MAX"
            rows="4"
            :placeholder="notesPlaceholder"
            :aria-invalid="notesError ? 'true' : 'false'"
            aria-describedby="notesHelp"
          ></textarea>
          <div class="char-counter" :class="{ warn: notesLeft <= 20 }">
            {{ form.notes.length }} / {{ NOTES_MAX }}
          </div>
        </div>

        <p id="notesHelp" class="help-text">
          僅做事後稽核使用，不會出現在對象端。
        </p>
      </div>

      <!-- 全域錯誤 -->
      <div v-if="errorMessage" class="error-box" role="alert">
        <p class="error-text">{{ errorMessage }}</p>
      </div>

      <!-- 動作列：返回 + 送出 -->
      <div class="actions">
        <button
          type="button"
          class="back-button"
          :disabled="isLoading"
          @click="emit('back-to-roles')"
          aria-label="返回角色選擇"
        >
          返回
        </button>

        <button
          type="submit"
          class="submit-button"
          :disabled="isSubmitDisabled || isLoading"
        >
          <span v-if="isLoading">處理中…</span>
          <span v-else>取得供服務對象掃描驗證之 QR Code</span>
        </button>
      </div>
    </form>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import type { RoleOption } from '~/components/VerifyStep1RoleSelection.vue'

/* Props */
const props = defineProps<{
  isLoading: boolean
  errorMessage: string | null
  roleOption: RoleOption
}>()

/* Emits（含回上一步、送出）*/
const emit = defineEmits<{
  (e: 'submit-verification', formData: {
    verificationMode: string
    role: string
    verifier: string
    reason: string          // 人類可讀（顯示文字）
    reasonCode: string      // 稽核碼（關鍵）
    reasonDesc: string      // 選項說明（可選）
    notes: string
  }): void
  (e: 'back-to-roles'): void
}>()

/* 狀態：驗證模式 */
const verificationMode = ref<'single' | 'batch'>('single')

/* ===== 用途進階型別與清單（預設全顯示，不過濾） ===== */
type ReasonOption = {
  code: string;        // 內部用途 / 稽核碼
  label: string;       // 下拉顯示文字
  desc: string;        // 選項說明（可做 tooltip）
  roles?: string[];    // 建議適用角色 key（此版不使用）
}

const reasonOptionsDetailed = ref<ReasonOption[]>([
  { code: 'MED_OUTPATIENT',   label: '一般就醫（門診/檢查結帳）', desc: '就醫流程核對社福資格與有效期限，協助結帳與轉介。', roles: ['medical','social_worker'] },
  { code: 'MED_EMERGENCY',    label: '緊急就醫（急診/轉診分流）', desc: '急診現場快速確認資格，縮短處置與醫療補助啟動時間。', roles: ['medical','police_fire','disaster_center'] },
  { code: 'NGO_RELIEF_BATCH', label: '領取物資（現場批次驗證）', desc: '批次 QR 驗證，避免名冊外流，只回覆是否符合與到期狀態。', roles: ['charity','disaster_center','local_office'] },
  { code: 'SUBSIDY_COUNSEL',  label: '補助諮詢（資格初步核對）', desc: '臨櫃/外勤諮詢前置核對，減少民眾往返與補件。', roles: ['local_office','social_worker','long_term_care'] },
  { code: 'ELIGIBILITY_QUICK',label: '身分/資格快速查核（到期與否）', desc: '僅確認資格與有效期，不揭露收入或家戶細節。', roles: ['medical','charity','local_office','social_ticket'] },
  { code: 'PRECHECK_FIRST',   label: '首次申請前審查（文件減量）', desc: '新案前置核對，讓後續申請一次到位。', roles: ['local_office','legal_aid','long_term_care'] },
  { code: 'PERIODIC_REVIEW',  label: '資格複查（年度/定期覆核）', desc: '定期覆核資格有效性，降低過期憑證風險。', roles: ['local_office','social_worker'] },
  { code: 'DISASTER_TRIAGE',  label: '災害救助分流（避難與安置）', desc: '災時分流與物資派發，支援批次驗證與最小揭露。', roles: ['disaster_center','police_fire','charity'] },
  { code: 'LTC_AT_HOME',      label: '長照到點服務（到宅核對）', desc: '居家服務到點核對與服務啟用，針對身份別提供服務。', roles: ['long_term_care','social_worker'] },
  { code: 'MED_SUBSIDY_RECON',label: '醫療補助結報（收據彙整）', desc: '醫療補助結報時核對等級與資格狀態，降低誤審。', roles: ['medical','social_worker'] },
  { code: 'EDU_TUITION',      label: '學雜費或助學金申請',       desc: '在學身分與社福資格核對，支援批次審查。', roles: ['high_school','university'] },
  { code: 'EDU_EVENT',        label: '校園活動/營隊優惠核對',     desc: '報名或入場核對優惠資格，避免收集多餘個資。', roles: ['high_school','university'] },
  { code: 'LEGAL_AID_INTAKE', label: '法律扶助初談評估',           desc: '初談時快速核對弱勢身份，避免重複蒐集敏感資料。', roles: ['legal_aid'] },
  { code: 'DISABILITY_AID',   label: '身障輔具補助申請/估價',       desc: '門市核對等級後辦理補助或估價，不留存個資。', roles: ['disability_aid'] },
  { code: 'NGO_PUBLIC_SUBSIDY',label:'公益/慈善補貼核對',         desc: '核對補貼資格與效期，留存匿名統計以利審核。', roles: ['charity','local_office'] },
  { code: 'SOCIAL_TICKET',    label: '票券/場館社福優惠入場',       desc: '入場口快速核對是否符合優惠。', roles: ['social_ticket'] }
])

const OTHER_OPTION: ReasonOption = {
  code: 'OTHER',
  label: '其他（請於備註說明）',
  desc: '不在清單中的用途，請於備註補充具體情境。'
}

/* 不做角色過濾：全清單 + OTHER */
const allReasons = computed<ReasonOption[]>(() => {
  return [...reasonOptionsDetailed.value, OTHER_OPTION]
})

/* 表單：以 code 存用途，利後端稽核 */
const form = ref({
  reasonCode: '',
  notes: ''
})

/* 便利：目前選中的完整選項（給 tooltip/稽核/placeholder） */
const selectedReason = computed<ReasonOption | null>(() => {
  return allReasons.value.find(r => r.code === form.value.reasonCode) || null
})

/* 備註字數限制與文案 */
const NOTES_MAX = 200
const notesLeft = computed(() => NOTES_MAX - form.value.notes.length)
const notesError = computed(() =>
  form.value.reasonCode === 'OTHER' && form.value.notes.trim().length === 0
)
const notesPlaceholder = computed(() =>
  form.value.reasonCode === 'OTHER'
    ? '請簡述目的（此欄為必填）'
    : (selectedReason.value?.desc || '例如：家中摔倒緊急就醫、檢查報到…')
)

/* 驗證狀態 */
const reasonValid = computed(() => !!form.value.reasonCode)
const verificationModeValid = computed(() => !!verificationMode.value)

/* 提交可否 */
const isSubmitDisabled = computed(() => {
  if (!reasonValid.value) return true
  if (form.value.reasonCode === 'OTHER' && notesError.value) return true
  return false
})

/* 送出 */
function handleSubmit() {
  if (isSubmitDisabled.value) return
  emit('submit-verification', {
    verificationMode: verificationMode.value,
    role: props.roleOption.name,
    verifier: props.roleOption.organizationName,
    reason: selectedReason.value?.label || '',
    reasonCode: selectedReason.value?.code || '',
    reasonDesc: selectedReason.value?.desc || '',
    notes: form.value.notes.trim()
  })
}
</script>

<style scoped lang="scss">
/* 色票（低飽和） */
$ink-900: #1f2732;
$ink-800: #2a3442;
$ink-700: #3b4758;
$ink-600: #4a5568;
$ink-500: #667085;
$ink-300: #a0aec0;
$ink-200: #cbd5e0;
$ink-100: #e6edf6;

$blue-600: #3a6ea5;
$blue-500: #4a7eb6;
$blue-100: #ebf5ff;
$red-600: #c53030;

/* Header */
.welcome-header {
  padding: 0 .5rem 1.25rem .5rem;
  border-bottom: 1px solid #e2e8f0;
  margin-bottom: 1.25rem;
}
.welcome-title {
  font-size: 1.35rem;
  font-weight: 800;
  color: $ink-800;
  margin: 0 0 .5rem 0;
}
.welcome-description {
  font-size: .92rem;
  color: $ink-600;
  line-height: 1.6;
  margin: 0;
}

/* 基本表單間距 */
.space-y-6 > * + * { margin-top: 1.25rem; }

.form-group {}
.form-label {
  display: block;
  font-size: .9rem;
  font-weight: 700;
  color: $ink-700;
  margin-bottom: .5rem;
}
.required-star { color: $red-600; margin-left: .25rem; }

/* 輸入元件 */
.form-input,
.form-select,
.form-textarea {
  display: block;
  width: 100%;
  padding: .7rem 1rem;
  font-size: 1rem;
  color: $ink-900;
  background-color: #fff;
  border: 1px solid $ink-200;
  border-radius: .5rem;
  box-shadow: 0 1px 2px rgba(0,0,0,.04);
  transition: box-shadow .15s ease, border-color .15s ease;

  &:focus {
    outline: none;
    border-color: $blue-500;
    box-shadow: 0 0 0 3px rgba(74, 126, 182, .25);
  }
  &::placeholder { color: $ink-300; }
}
.form-select { appearance: none; }

/* 自訂下拉箭頭（SVG） */
.select-wrapper { position: relative; }
.select-caret {
  position: absolute;
  right: .75rem;
  top: 50%;
  transform: translateY(-50%);
  width: 20px;
  height: 20px;
  color: $ink-500;
  pointer-events: none;
}

/* 備註字數 */
.textarea-with-counter { position: relative; }
.char-counter {
  position: absolute;
  right: .5rem;
  bottom: .4rem;
  font-size: .8rem;
  color: $ink-500;
  user-select: none;
}
.char-counter.warn { color: #8c5a5a; }
.form-textarea.has-error {
  border-color: #e78a8a;
  box-shadow: 0 0 0 3px rgba(231,138,138,.2);
}

/* 輔助文字與錯誤 */
.help-text {
  margin: .4rem 0 0 0;
  font-size: .82rem;
  color: $ink-500;
}
.badge-required {
  margin-left: .5rem;
  padding: .15rem .4rem;
  border-radius: .4rem;
  font-size: .72rem;
  font-weight: 800;
  color: #7a2e2e;
  background: rgba(236, 102, 102, .12);
  border: 1px solid rgba(236, 102, 102, .35);
}

/* 錯誤盒 */
.error-box {
  margin-top: .75rem;
  padding: .75rem;
  background: rgba(241, 99, 99, 0.08);
  border: 1px solid rgba(241, 99, 99, 0.35);
  border-radius: .5rem;
  text-align: center;
}
.error-text {
  margin: 0;
  font-size: .95rem;
  font-weight: 800;
  color: #a61b1b;
}

/* 動作列：返回 + 送出 */
.actions{
  display: grid;
  grid-template-columns: 1fr 1.4fr; /* 返回較小、送出較大 */
  gap: .75rem;
  align-items: stretch;

  @media (max-width: 480px){
    grid-template-columns: 1fr; /* 手機直向改為上下堆疊 */
  }
}

.back-button{
  width: 100%;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: .78rem 1rem;
  font-size: .95rem;
  font-weight: 800;
  color: #334155;
  background: linear-gradient(180deg, #f7fafc 0%, #ffffff 100%);
  border: 1px solid #cbd5e1;
  border-radius: .6rem;
  box-shadow: 0 6px 14px rgba(2,6,23,.06);
  cursor: pointer;
  transition: transform .08s ease, box-shadow .2s ease, border-color .2s ease, color .2s ease;

  &:hover{ border-color:#94a3b8; box-shadow:0 10px 20px rgba(2,6,23,.10); }
  &:active{ transform: translateY(0); }
  &:disabled{ opacity:.55; cursor:not-allowed; box-shadow:none; }
}

/* 送出按鈕 */
.submit-button {
  width: 100%;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: .85rem 1.5rem;
  font-size: 1rem;
  font-weight: 800;
  color: #fff;
  background: $blue-600;
  border: 1px solid rgba(58,110,165,.35);
  border-radius: .6rem;
  box-shadow: 0 10px 24px rgba(58,110,165,.18);
  cursor: pointer;
  transition: transform .08s ease, box-shadow .2s ease, background-color .2s ease, opacity .2s ease;

  &:hover { background: #356593; }
  &:active { transform: translateY(0); }
  &:disabled {
    opacity: .55;
    cursor: not-allowed;
    background: #9fb4cc;
    box-shadow: none;
  }
}

/* Radio Group */
.radio-group {
  display: grid;
  gap: .75rem;
}
.radio-label {
  display: grid;
  grid-template-columns: auto 1fr;
  grid-template-rows: auto auto;
  gap: .5rem .75rem;
  align-items: center;

  padding: .9rem 1rem;
  background: #fff;
  border: 2px solid #e2e8f0;
  border-radius: .65rem;
  cursor: pointer;
  transition: border-color .15s ease, box-shadow .15s ease, background-color .15s ease;

  &.selected {
    border-color: $blue-500;
    background: $blue-100;
    box-shadow: 0 0 0 1px $blue-500;
  }
}
.radio-input {
  appearance: none;
  width: 0;
  height: 0;
  opacity: 0;
  position: absolute;
}
.radio-icon {
  width: 22px;
  height: 22px;
  color: $blue-600;
  grid-row: 1 / span 2;
}
.radio-texts { display: contents; }
.radio-title {
  font-weight: 800;
  color: $ink-800;
}
.radio-description {
  font-size: .9rem;
  color: $ink-600;
}

/* RWD 微調 */
@media (max-width: 480px) {
  .welcome-title { font-size: 1.2rem; }
  .welcome-description { font-size: .88rem; }
  .radio-description { font-size: .86rem; }
  .submit-button { font-size: .95rem; padding: .8rem 1.25rem; }
}
</style>
