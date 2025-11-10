<!-- components/Step1Verification.vue -->
<template>
  <div class="step1">
    <p class="subtitle">步驟 1：選擇免插卡驗證方式</p>

    <!-- 驗證方式（改為並排） -->
    <div class="options">
      <p class="options-prompt">請選擇一種方式開始申領您的社福數位憑證：</p>

      <div class="options-grid">
        <!-- 手機門號 + 健保卡卡號 -->
        <button
          class="option"
          :disabled="isLoading"
          @click="emit('start-verification', 'nhi_card')"
        >
          <span class="option-icon" aria-hidden="true">
            <!-- 卡片 + SIM 構圖 -->
            <svg viewBox="0 0 24 24" class="ico">
              <path d="M7 3h6l5 5v9a4 4 0 0 1-4 4H7a4 4 0 0 1-4-4V7a4 4 0 0 1 4-4Z" fill="currentColor" opacity=".12"/>
              <path d="M13 3v4a2 2 0 0 0 2 2h4" stroke="currentColor" stroke-width="1.6" fill="none"/>
              <rect x="6.75" y="12" width="6.5" height="4.5" rx="1" ry="1" stroke="currentColor" stroke-width="1.6" fill="none"/>
              <path d="M9 13.5v1.5m2-1.5v1.5m2-1.5v1.5" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/>
            </svg>
          </span>
          <span class="option-body">
            <span class="option-title">手機門號 + 健保卡卡號驗證</span>
            <span class="option-desc">請準備：本人名下手機門號、健保卡卡號（請先關閉 Wi-Fi）</span>
          </span>
        </button>

        <!-- 行動自然人憑證 -->
        <button
          class="option"
          :disabled="isLoading"
          @click="emit('start-verification', 'mobile_id')"
        >
          <span class="option-icon" aria-hidden="true">
            <!-- 行動身分/盾牌 -->
            <svg viewBox="0 0 24 24" class="ico">
              <rect x="7" y="3" width="10" height="18" rx="2.5" ry="2.5" stroke="currentColor" stroke-width="1.6" fill="none"/>
              <circle cx="12" cy="17.5" r="0.9" fill="currentColor"/>
              <path d="M12 7c2.2 0 4 1.8 4 4v.6c0 .6-.3 1.1-.8 1.4l-2.4 1.3a2 2 0 0 1-1.7 0l-2.3-1.3a1.6 1.6 0 0 1-.8-1.4V11c0-2.2 1.8-4 4-4Z" fill="currentColor" opacity=".12"/>
              <path d="M12 8.2c1.5 0 2.8 1.2 2.8 2.8v.5c0 .4-.2.8-.6 1l-1.7.9a1.2 1.2 0 0 1-1.1 0l-1.6-.9c-.3-.2-.6-.6-.6-1v-.5c0-1.6 1.2-2.8 2.8-2.8Z" stroke="currentColor" stroke-width="1.6" fill="none"/>
            </svg>
          </span>
          <span class="option-body">
            <span class="option-title">行動自然人憑證</span>
            <span class="option-desc">請先下載 App 並完成註冊與裝置綁定（Android / iOS）</span>
          </span>
        </button>
      </div>
    </div>

    <!-- 下載 App 區（放在驗證方式之後） -->
    <section class="download-card">
      <div class="group-head">
        <svg class="info-icon" viewBox="0 0 24 24" aria-hidden="true" focusable="false">
          <path d="M12 8.5a1.25 1.25 0 1 0 0-2.5 1.25 1.25 0 0 0 0 2.5zM11 10h2v7h-2z" />
          <path d="M12 2a10 10 0 1 1 0 20A10 10 0 0 1 12 2zm0 2a8 8 0 1 0 0 16 8 8 0 0 0 0-16z" />
        </svg>
        <h3 class="group-title">尚未安裝「數位皮夾 App」？掃描下載即可開始</h3>
      </div>

      <div class="store-group">
        <div class="store-col">
          <div class="qr"><img src="/androidQrcode.png" alt="Android 版下載 QR Code" /></div>
          <a class="store-badge" href="https://play.google.com/apps/testing/tw.gov.moda.diw" target="_blank" rel="noopener">
            <img src="/googleplay.png" alt="Get it on Google Play" />
          </a>
          <p class="sys-note">支援 Android 10 以上（含）</p>
        </div>

        <div class="store-col">
          <div class="qr"><img src="/iosQrcode.png" alt="iOS 版下載 QR Code" /></div>
          <a class="store-badge" href="https://testflight.apple.com/join/gxr3mQFj" target="_blank" rel="noopener">
            <img src="/applestore.png" alt="Download on the App Store" />
          </a>
          <p class="sys-note">支援 iOS 15.0 以上（含）</p>
        </div>
      </div>

      <p class="small-tip">
        也可直接使用上方任一驗證方式開始模擬（流程將隨機產生測試資料，不會讀取真實個資）。
      </p>
    </section>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{ isLoading: boolean }>()
const emit = defineEmits<{ (e: 'start-verification', method: 'nhi_card' | 'mobile_id'): void }>()
</script>

<style scoped>
.step1 { overflow-x: hidden; }
.step1 * { box-sizing: border-box; }
.step1 :where(img, svg) { max-width: 100%; height: auto; }

/* 副標題 */
.subtitle{
  text-align: center;
  margin: 0 0 1rem 0;
  font-weight: 800;
  font-size: 1.06rem;
  color: #d0a07e;
}

/* ====== 驗證方式（並排） ====== */
.options{ margin-top: 0.25rem; }
.options-prompt{
  text-align: center; font-weight: 700; color: #3a4655; margin: .2rem 0 .6rem;
}

/* 自適應 2 欄：寬度足夠時並排，太窄會自動換行；也可固定 2 欄見下方媒體查詢 */
.options-grid{
  display: grid;
  gap: 12px;
  grid-template-columns: repeat(2, minmax(0, 1fr));
}

/* 卡片按鈕 */
.option{
  width: 100%;
  display: grid;
  grid-template-columns: 56px 1fr;
  gap: 12px;
  align-items: center;
  padding: 14px 16px;
  border-radius: 16px;
  background: rgba(255,255,255,0.16);
  border: 2px solid rgba(226,232,240,0.8);
  box-shadow: 0 8px 22px rgba(23,43,77,.08);
  cursor: pointer;
  transition: box-shadow .2s ease, transform .06s ease, border-color .2s ease, background .2s ease;
}
.option:hover{
  background: rgba(255,255,255,0.22);
  border-color: rgba(186,201,255,.8);
  box-shadow:
    inset 0 0 0 2px rgba(186,201,255,.45),
    0 12px 26px rgba(23,43,77,.12);
}
.option:active{ transform: translateY(1px); }
.option:disabled{
  opacity: .6; cursor: wait;
  background: rgba(245,247,250,0.6);
  border-color: rgba(226,232,240,0.7);
}

/* SVG 圖示（取代表情符號） */
.option-icon{
  display: grid; place-items: center;
  width: 56px; height: 56px;
  color: #2f5e72;
}
.option-icon .ico{
  width: 28px; height: 28px; /* 明確控制大小 */
  display: block;
}

.option-body{ display: grid; gap: 4px; text-align: left; }
.option-title{ font-weight: 800; font-size: 1.02rem; color: #25313f; }
.option-desc{ font-size: .92rem; color: #5e6b7a; }

/* ====== 下載 App 區 ====== */
.download-card{
  background: linear-gradient(180deg, rgba(255,255,255,0.60), rgba(255,255,255,0.06));
  padding: clamp(12px, 2.2vw, 18px);
  margin-top: 0.9rem;
}
.group-head{
  display: grid;
  grid-template-columns: 22px 1fr;
  align-items: center;
  gap: 8px;
  margin-bottom: .5rem;
}
.info-icon{
  width: 22px !important;
  height: 22px !important;
  flex: 0 0 22px;
  display: block;
  color: #3d7488;
}
.info-icon path{ fill: currentColor; }
.group-title{
  margin: 0;
  font-size: 1rem;
  font-weight: 800;
  color: #223041;
}

/* 兩平台成組，並排 */
.store-group{
  margin-top: .25rem;
  padding: 10px;
  border: 1px dashed rgba(186,201,255,0.45);
  border-radius: 12px;
  background: linear-gradient(180deg, rgba(255,255,255,0.22), rgba(255,255,255,0.08));
  display: grid;
  gap: 10px;
  grid-template-columns: repeat(2, minmax(0, 1fr));
}
.store-col{
  display: grid;
  justify-items: center;
  align-items: start;
  gap: 6px;
  padding: 6px;
}
.qr{ width: 78px; height: 78px; overflow: hidden; }
.qr img{ display: block; width: 100%; height: 100%; object-fit: cover; }

.store-badge{
  display: inline-flex; align-items: center;
  overflow: hidden;
  transition: transform .08s ease;
}
.store-badge:hover{ transform: translateY(-1px); }
.store-badge img{ display: block; height: 34px; width: auto; }

.sys-note{ margin: 0; font-size: .82rem; color: #516173; }
.small-tip{ margin: 10px 2px 0; font-size: .9rem; color: #5e6b7a; text-align: center; }

/* ====== RWD ====== */
@media (max-width: 640px){
  /* 仍維持並排，但卡片更緊湊，避免擠壓 */
  .option{ grid-template-columns: 50px 1fr; padding: 12px 12px; }
  .option-icon{ width: 50px; height: 50px; }
  .option-icon .ico{ width: 26px; height: 26px; }
  .option-title{ font-size: 1rem; }
  .option-desc{ font-size: .88rem; }

  /* QR/徽章比例更小，兩欄依舊 */
  .qr{ width: 72px; height: 72px; }
  .store-badge img{ height: 32px; }
}

@media (max-width: 420px){
  /* 超小螢幕才允許換成單欄，避免字被擠到不可讀 */
  .options-grid{ grid-template-columns: 1fr; }
  .store-group{ grid-template-columns: 1fr; }
}
</style>
