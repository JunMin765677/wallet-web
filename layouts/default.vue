<!-- layouts/default.vue -->
<template>
  <div class="screen">
    <AppNav />

    <main id="main" class="content">
      <slot />
    </main>

    <footer class="foot">
      <small>© {{ new Date().getFullYear() }} 暖心e證通</small>
    </footer>
  </div>
</template>

<script setup lang="ts">
// Nuxt 3 預設自動匯入 components，若有關掉 auto-import，請手動：
// import AppNav from '~/components/AppNav.vue'
</script>

<style>
:root{
  /* 全域主題（低飽和、霧化、與 AppNav 共用變數） */
  --font: 1.25rem;
  --bg-mask: rgba(15, 23, 42, 0.28);
  --glass: rgba(255,255,255,0.16);
  --glass-strong: rgba(255,255,255,0.24);
  --ink: #e8eef6;
  --muted: rgba(232,238,246,0.75);

  --edge-1: rgba(210, 255, 227, 0.8);
  --edge-2: rgba(186, 201, 255, 0.3);
  --edge-3: rgba(248, 249, 255, 0.5);

  --brand-a: #86c5d6;
  --brand-b: #f1c7b3;

  --radius: 1.25rem;
  --shadow: 0 20px 50px rgba(2, 6, 23, 0.25);
  --ring: 0 0 0 3px rgba(134,197,214,.35);
}

html, body, #__nuxt { height: 100%; }
body{
  margin: 0;
  font-family: 'Open Sans', ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial;
  color: var(--ink);

  /* ✅ 使用可重複的背景圖 */
  background-image: url('/bg.webp');
  background-repeat: repeat;        /* 重複平鋪 */
  background-position: top left;    /* 也可改成 center top */
  background-size: auto;            /* 維持原圖大小 */
}

.screen{
  min-height: 100vh;
  display: grid;
  grid-template-rows: auto 1fr auto;
  gap: 1.25rem;
}

/* 內容容器（半透明卡片，與你原本頁面 slot 相容） */
.content{
  display: grid; place-items: stretch;
  padding: 2rem 1.25rem 3rem;
}
/* ✅ 防溢出的安全版本 */
.content > *:first-child,
.content section {
  margin: 0 auto;

  /* 關鍵：讓 padding 計入寬度，避免在手機超出 */
  box-sizing: border-box;

  /* 寬度上限 1100px，平時撐滿容器，但不超過畫面 */
  inline-size: min(100%, 1100px);

  /* 內距用 clamp，手機不會太擠，桌機不會太寬鬆 */
  padding: clamp(12px, 2.5vw, 20px);

  /* 你原本的視覺樣式保留 */
  /* background: linear-gradient(180deg, rgba(255, 255, 255, .14), rgba(255, 255, 255, .08));
  border: 1px solid rgba(255, 255, 255, .18);
  border-radius: calc(var(--radius) + .5rem);
  box-shadow: var(--shadow); */
}

/* 依螢幕調整外層 content 的左右邊距，避免貼邊 */
@media (max-width: 480px) {
  .content { padding-inline: 12px; }
}

/* 頁腳 */
.foot{
  padding: 0 1.25rem 1.5rem;
  color: var(--muted);
  text-align: center;
}
</style>
