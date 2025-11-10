<template>
  <div>
    <p class="subtitle">步驟 2: 申領您的社福數位憑證</p>
    <p class="prompt-text">您符合以下身份資格，請選擇要申領的項目：</p>

    <div class="vc-list-container">
      <div
        v-for="template in availableTemplates"
        :key="template.id"
        class="vc-list-item"
        :class="{ 'is-active': issuanceStatusMap.has(template.id) }"
      >
        <div class="vc-info-header">
          <img
            class="vc-card-img"
            :src="template.cardImageUrl"
            alt=""
            loading="lazy"
            referrerpolicy="no-referrer"
          />
          <span class="vc-title">{{ template.templateName }}</span>
          <span class="vc-description">
            {{ template.description || '點此申領此憑證' }}
          </span>

          <span
            v-if="issuanceStatusMap.has(template.id)"
            class="vc-status-badge"
            :class="getStatusClass(statusValue(template.id))"
          >
            <span class="vc-status-text">{{ getStatusText(statusValue(template.id)) }}</span>
          </span>

          <button
            v-else
            class="vc-action-button"
            :disabled="isLoading"
            @click="emit('select-vc', template.id)"
            type="button"
          >
            申領
          </button>
        </div>

        <Transition name="reveal">
          <div
            v-if="issuanceStatusMap.has(template.id)"
            class="vc-issuance-details"
          >
            <template v-if="statusValue(template.id) === 'loading'">
              </template>

            <template v-else-if="statusValue(template.id) === 'initiated'">
              <div class="qr-focus">
                <img
                  v-if="statusOf(template.id)?.qrCode"
                  :src="statusOf(template.id)?.qrCode"
                  alt="申領用 QR Code"
                  class="qr-code-image"
                />
                <div v-else class="qr-skeleton" aria-hidden="true"></div>
                <p class="qr-caption">請以「數位皮夾 App」掃描上方 QR Code</p>
              </div>

              <div class="divider">
                <span class="divider-text">或</span>
              </div>

              <a
                :href="statusOf(template.id)?.deepLink"
                target="_blank"
                rel="noopener noreferrer"
                class="deep-link-button"
                type="button"
              >
                點此開啟數位皮夾 App
              </a>

              <div class="polling-status" role="status" aria-live="polite">
                <p class="pending">
                  {{ statusOf(template.id)?.message || '等待 App 掃描...' }}
                </p>
              </div>

              <button
                @click="emit('cancel-issuance', template.id)"
                class="back-button-small"
                :disabled="isLoading"
                type="button"
              >
                取消
              </button>
            </template>

            <template v-else-if="statusValue(template.id) === 'issued'">
              </template>

            <template v-else-if="statusValue(template.id) === 'expired' || statusValue(template.id) === 'error'">
              </template>
          </div>
        </Transition>
      </div>
    </div>

    <div class="back-button-wrapper">
      <button @click="emit('back-to-step1')" class="back-button" :disabled="isLoading" type="button">
        返回身份驗證
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
/* (Script 區塊不需修改) */
const { isLoading, availableTemplates, issuanceStatusMap } = defineProps<{
  isLoading: boolean;
  availableTemplates: any[];
  issuanceStatusMap: Map<string, any>;
}>();

const emit = defineEmits<{
  (e: 'select-vc', templateId: string): void;
  (e: 'back-to-step1'): void;
  (e: 'cancel-issuance', templateId: string): void;
}>();

function statusOf(id: string): any | undefined {
  return issuanceStatusMap?.get?.(id);
}
function statusValue(id: string): string | undefined {
  return statusOf(id)?.status as string | undefined;
}
function getStatusText(status?: string) {
  switch (status) {
    case 'issued':    return '領取成功';
    case 'expired':   return '已過期';
    case 'error':     return '發生錯誤';
    case 'loading':   return '處理中';
    case 'initiated': return '待領取';
    default:          return '待領取';
  }
}
function getStatusClass(status?: string) {
  switch (status) {
    case 'issued':                return 'success';
    case 'expired':
    case 'error':                 return 'error';
    case 'loading':
    case 'initiated':
    default:                      return 'pending';
  }
}
</script>

<style lang="scss" scoped>
/* ===== 色票（低飽和） ===== */
$ink-800: #2a3442;
$ink-700: #3a4658;
$ink-600: #4a596d;
$ink-500: #5c6c82;
$ink-400: #6e8198;
$ink-300: #8da0b6;
$ink-200: #b4c0cf;
$ink-100: #dfe6ee;
$paper:   #f7f9fb;
$white:   #ffffff;

$y-50:  #fffbea;
$y-200: #fde68a;
$y-700: #8a4d08;

$g-50:  #f3faf5;
$g-200: #b7e3c4;
$g-700: #487965;

$r-50:  #fef3f2;
$r-200: #fbc8c4;
$r-700: #9b1c1c;

$b-600: #3a6ea5;
$b-700: #2f5b88;

/* 文案區 */
.subtitle { font-size:1rem; color:#d0a07e; text-align:center; margin-bottom:2rem; letter-spacing:.02em; }
.prompt-text { text-align:center; color:$ink-600; font-weight:600; margin-bottom:1.5rem; }

/* 列表容器 */
.vc-list-container { display:flex; flex-direction:column; gap:1rem; }

/* 卡片 */
.vc-list-item {
  background-color:$white;
  border:1px solid $ink-100;
  border-radius:.9rem;
  box-shadow:0 1px 2px rgba(0,0,0,.04);
  transition:border-color .25s ease, box-shadow .25s ease;
  overflow:hidden;

  &.is-active {
    border-color: rgba(58,110,165,.35);
    box-shadow: 0 6px 22px rgba(58,110,165,.08);
  }
}

/* ========== A. 憑證資訊列：統一改為 Grid ========== */
.vc-info-header {
  /* * [修改] 
   * * 統一使用 Grid，不再區分桌面/手機
   */
  display: grid;
  grid-template-columns: 100px 1fr auto; /* [修改] 圖片固定 100px */
  grid-template-areas:
    "img title action"
    "img desc  action";
  align-items: center;
  column-gap: 1rem; /* [修改] 統一欄間距 */
  row-gap: .25rem;
  padding: 1rem; /* [修改] 統一 padding */
}

.vc-card-img {
  /* [修改] 圖片放大 */
  width: 100px;
  height: 100px;
  object-fit: cover;
  border-radius: .6rem; /* [修改] 圓角配合放大 */
  border: 1px solid $ink-100;
  background: $paper;
  flex-shrink: 0;
  grid-area: img; /* [修改] 指定 grid 區域 */
}

/* 文字區：為 5–9 字的標題 + 10+ 字的描述做優化 */
.vc-title {
  grid-area: title; /* [修改] 指定 grid 區域 */
  font-size: 1.05rem;
  font-weight: 800;
  color: $ink-800;
  display: block;
  line-height: 1.25rem;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;

  @media (max-width: 767px) {
    font-size: 1.02rem;
    margin-top: .05rem;
  }
}

/* ✅ 專為 10+ 字的描述設計：
   - Mobile：兩行夾省略，字級略降，避免擠壓行動區
   * - Desktop：單行省略
   */
.vc-description {
  grid-area: desc; /* [修改] 指定 grid 區域 */
  color: $ink-500;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  overflow: hidden;

  @media (max-width: 767px) {
    font-size: .86rem;
    line-height: 1.2rem;
    -webkit-line-clamp: 2;
    max-height: calc(1.2rem * 2);
    margin-top: .05rem;
  }

  @media (min-width: 768px) {
    font-size: .9rem;
    line-height: 1.25rem;
    -webkit-line-clamp: 1;
    max-height: 1.25rem;
    white-space: nowrap;
    text-overflow: ellipsis;
  }
}

/* 行動區（狀態徽章或按鈕） */
.vc-status-badge,
.vc-action-button {
  grid-area: action; /* [修改] 指定 grid 區域 */
  align-self: start; /* 與 title 對齊頂部，減少高度跳動 */
}

/* 申領按鈕 */
.vc-action-button {
  padding: .5rem .9rem;
  font-weight: 800;
  border-radius: .55rem;
  background-color: $b-600;
  color: $white;
  border: none;
  cursor: pointer;
  transition: transform .08s ease, box-shadow .2s ease, background-color .2s ease;
  &:hover { background-color: $b-700; }
  &:active { transform: translateY(1px); }
  &:disabled { opacity: .55; cursor: wait; }

  @media (max-width: 767px) {
    font-size: .92rem;
    white-space: nowrap;
  }
}

/* 狀態徽章（含 SVG） */
.vc-status-badge {
  display: inline-flex;
  align-items: center;
  gap: .4rem;
  padding: .25rem .6rem;
  font-size: .86rem;
  font-weight: 800;
  border-radius: 999px;
  border: 1px solid transparent;
  &.pending { background-color: $y-50; border-color: $y-200; color: $y-700; }
  &.success { background-color: $g-50; border-color: $g-200; color: $g-700; }
  &.error { background-color: $r-50; border-color: $r-200; color: $r-700; }
}
.vc-status-icon .icon { width: 16px; height: 16px; display: block; }
.vc-status-icon .spinner { animation: spin 1s linear infinite; }
@keyframes spin { to { transform: rotate(360deg); } }

/* 展開區（沿用上一版） */
.vc-issuance-details {
  border-top: 1px solid $ink-100;
  background:
    radial-gradient(180px 90px at 20% -10%, rgba(58,110,165,.06), transparent 60%),
    linear-gradient(180deg, $paper 0%, $white 100%);
  padding: 1rem 1.1rem 1.25rem;
}

/* loading 視覺 */
.progress-track { width: 100%; height: 6px; border-radius: 999px; background: #eef2f6; overflow: hidden; margin-bottom: .75rem; }
.progress-indicator { height: 100%; width: 40%; border-radius: 999px; background: linear-gradient(90deg, #bcd3ea, #8fb4d8, #bcd3ea); animation: indeterminate 1.2s infinite linear; }
@keyframes indeterminate { 0% { transform: translateX(-120%); } 100% { transform: translateX(280%); } }
.final-status-head { display: flex; align-items: center; gap: .5rem; }
.final-status-icon .icon { width: 20px; height: 20px; display: block; }

/* 終態框 */
.final-status-box {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  padding: 1rem;
  border-radius: .75rem;
  border: 1px solid transparent;
  &.success { background-color: $g-50; border-color: $g-200; color: $g-700; }
  &.error { background-color: $r-50; border-color: $r-200; color: $r-700; }
  &.pending { background-color: $y-50; border-color: $y-200; color: $y-700; }
}
.final-status-title { font-size: 1.05rem; font-weight: 900; color: $ink-800; }
.final-status-message { font-size: .92rem; color: $ink-600; margin-top: .25rem; }

/* QR 焦點區 */
.qr-focus { display: flex; flex-direction: column; align-items: center; gap: .5rem; }
.qr-code-image {
  width: 240px;
  height: 240px;
  max-width: 100%;
  border-radius: .75rem;
  border: 1px solid $ink-100;
  background-color: $white;
  box-shadow: 0 6px 18px rgba(0,0,0,.06);
}
.qr-skeleton {
  width: 240px;
  height: 240px;
  border-radius: .75rem;
  background: linear-gradient(90deg, #eef2f6, #f6f8fb, #eef2f6);
  background-size: 200% 100%;
  animation: shimmer 1.2s infinite linear;
}
@keyframes shimmer { to { background-position: -200% 0; } }
.qr-caption { font-size: .92rem; color: $ink-600; }

/* [⭐️ 3. 已補上] "或" 分隔線 */
.divider {
  display: flex;
  align-items: center;
  text-align: center;
  margin: 1rem 0; /* 上下間距 */

  &::before,
  &::after {
    content: '';
    flex: 1;
    border-bottom: 1px solid $ink-100;
  }
  .divider-text {
    padding: 0 1rem;
    font-size: .875rem;
    color: $ink-300;
    font-weight: 600;
  }
}

/* [⭐️ 4. 已補上] Deep Link 按鈕 */
.deep-link-button {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  padding: .75rem 1rem;
  font-size: 1rem;
  font-weight: 800;
  border-radius: .6rem;
  background-color: $g-700; /* 使用 "成功" 的綠色 */
  color: $white;
  text-decoration: none;
  border: none;
  cursor: pointer;
  transition: all .2s ease;

  &:hover {
    background-color: #1b563e; /* $g-700 變深 */
  }
}

/* polling */
.polling-status { text-align: center; font-size: .9rem; color: $ink-600; margin-top: 1rem; min-height: 1.25rem; }
.polling-status .pending { font-weight: 700; color: $y-700; }

/* 共用按鈕 */
.back-button-wrapper { text-align: center; margin-top: 2rem; }
.back-button,
.back-button-small {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: .55rem 1.2rem;
  border-radius: .6rem;
  border: none;
  cursor: pointer;
  background-color: $ink-500;
  color: $white;
  font-weight: 800;
  transition: transform .08s ease, box-shadow .2s ease, background-color .2s ease, opacity .2s ease;
  &:hover { background-color: $ink-600; }
  &:active { transform: translateY(1px); }
  &:disabled { opacity: .55; cursor: not-allowed; }
}
.back-button-small { margin: 1rem auto 0; padding: .45rem .95rem; font-size: .92rem; }
.retry-button { background-color: $b-600; &:hover { background-color: $b-700; } }

/* 展開動畫 */
.reveal-enter-active,
.reveal-leave-active {
  transition: opacity .22s ease, transform .22s ease, filter .22s ease;
  transform-origin: top;
}
.reveal-enter-from,
.reveal-leave-to {
  opacity: 0;
  transform: scaleY(0.98);
  filter: blur(2px);
}
</style>