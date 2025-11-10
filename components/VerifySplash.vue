<!-- components/VerifySplash.vue -->
<template>
  <div
    class="splash-container"
    :class="{ 'fade-out': fadingOut }"
    role="dialog"
    aria-label="啟動畫面"
    aria-modal="true"
  >
    <div class="splash-bg" aria-hidden="true"></div>

    <div class="logo-block">
      <div class="logo-circle" aria-hidden="true">
        <svg xmlns="http://www.w3.org/2000/svg" class="logo-mark" viewBox="0 0 24 24">
          <circle cx="12" cy="12" r="10" fill="none" stroke="currentColor" stroke-width="2" opacity=".22"/>
          <path d="M9 12.75L11.25 15 15 9.75" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
      </div>
      <span class="logo-text">暖心e憑證</span>
      <span class="logo-sub">Digital Credential</span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'

const props = withDefaults(defineProps<{
  showMs?: number
  fadeMs?: number
}>(), {
  showMs: 1500,
  fadeMs: 500,
})

const emit = defineEmits<{ (e: 'splash-ended'): void }>()

const fadingOut = ref(false)

onMounted(() => {
  const show = Math.max(0, props.showMs)
  const fade = Math.max(100, props.fadeMs)
  setTimeout(() => {
    fadingOut.value = true
    setTimeout(() => emit('splash-ended'), fade)
  }, show)
})
</script>

<style lang="scss" scoped>
/* ===== 更淡、更輕的色系（可依需要再微調） ===== */
:root {
  --splash-bg-1: rgba(120, 160, 200, .06);
  --splash-bg-2: rgba(140, 170, 195, .05);
  --splash-grad-top: #ffffff;
  --splash-grad-bottom: #fafcff;

  --splash-accent: #6f94b8;     /* 主題藍（淡） */
  --splash-accent-ink: #2b3643; /* 文字墨色（淡） */
  --splash-ink-sub: #7c8da3;    /* 次要文字 */
}

/* ===== 佔滿可視區且真正置中 ===== */
.splash-container {
  position: fixed;
  inset: 0;
  width: 100vw;
  min-height: 100dvh; /* 避免行動裝置網址列收合造成高度誤差 */
  padding: env(safe-area-inset-top) env(safe-area-inset-right)
           env(safe-area-inset-bottom) env(safe-area-inset-left);

  display: flex;
  align-items: center;
  justify-content: center;

  z-index: 9999;
  opacity: 1;
  transition: opacity .45s ease-out;
}
.splash-container.fade-out {
  opacity: 0;
  pointer-events: none;
}

/* ===== 背景：極淡漸層 + 輕微紋理（非常淺） ===== */
.splash-bg {
  position: absolute;
  inset: 0;
  background:
    radial-gradient(240px 120px at 20% -10%, var(--splash-bg-1), transparent 55%),
    radial-gradient(260px 130px at 120% 10%, var(--splash-bg-2), transparent 60%),
    linear-gradient(180deg, var(--splash-grad-top) 0%, var(--splash-grad-bottom) 100%);
}
.splash-bg::after {
  content: '';
  position: absolute; inset: 0;
  background-image: radial-gradient(rgba(0,0,0,.025) 1px, transparent 1px);
  background-size: 16px 16px;
  pointer-events: none;
  opacity: .6; /* 很淡的網點 */
}

/* ===== 中央 Logo 區塊（確保嚴格置中） ===== */
.logo-block {
  position: relative;
  z-index: 1;

  display: grid;
  justify-items: center;
  gap: .55rem;
  text-align: center;

  color: var(--splash-accent);
  animation: rise .5s cubic-bezier(.22,.8,.3,1) both;
}

.logo-circle {
  display: grid;
  place-items: center;
  width: clamp(72px, 18vw, 96px);
  height: clamp(72px, 18vw, 96px);
  border-radius: 999px;

  background:
    radial-gradient(60% 60% at 30% 25%, rgba(255,255,255,.9), rgba(255,255,255,0)),
    linear-gradient(180deg, #f2f7fc 0%, #ffffff 100%);
  border: 1px solid rgba(111,148,184,.18);
  box-shadow:
    0 10px 26px rgba(17, 24, 39, .08),
    inset 0 1px 0 rgba(255,255,255,.75);

  animation: gentle 2.6s ease-in-out infinite;
}

.logo-mark {
  width: 58%;
  height: 58%;
  color: var(--splash-accent);
  filter: drop-shadow(0 1px 0 rgba(255,255,255,.7));
}

/* 文字更輕、更淡 */
.logo-text {
  font-weight: 800;
  font-size: clamp(1.02rem, 2.4vw, 1.32rem);
  line-height: 1.08;
  letter-spacing: .02em;
  color: var(--splash-accent-ink);
}
.logo-sub {
  font-weight: 600;
  font-size: clamp(.8rem, 2.1vw, .95rem);
  letter-spacing: .08em;
  text-transform: uppercase;
  color: var(--splash-ink-sub);
}

/* 動畫（很輕） */
@keyframes rise {
  from { transform: translateY(4px); opacity: 0; filter: blur(1.5px); }
  to   { transform: translateY(0);   opacity: 1; filter: blur(0); }
}
@keyframes gentle {
  0%, 100% { transform: scale(1); }
  50%      { transform: scale(1.015); }
}

/* 使用者偏好：減少動畫 */
@media (prefers-reduced-motion: reduce) {
  .splash-container { transition: none; }
  .logo-block,
  .logo-circle { animation: none !important; }
}

/* 深色模式（同樣更淡） */
@media (prefers-color-scheme: dark) {
  :root {
    --splash-bg-1: rgba(150, 180, 210, .10);
    --splash-bg-2: rgba(160, 185, 210, .08);
    --splash-grad-top: #0e1526;
    --splash-grad-bottom: #0b1220;

    --splash-accent: #97b2cc;
    --splash-accent-ink: #e6eef7;
    --splash-ink-sub: #aab8cb;
  }
  .logo-circle {
    background:
      radial-gradient(60% 60% at 30% 25%, rgba(255,255,255,.05), rgba(255,255,255,0)),
      linear-gradient(180deg, #0f1b2e 0%, #0c1526 100%);
    border-color: rgba(151,178,204,.26);
    box-shadow:
      0 10px 26px rgba(5,12,24,.5),
      inset 0 1px 0 rgba(255,255,255,.06);
  }
}
</style>
