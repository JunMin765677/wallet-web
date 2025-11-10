<!-- components/AppNav.vue -->
<template>
  <header class="nav-wrap" :class="{ 'is-open': mobileOpen }">
    <div class="row">
      <!-- 只在左側保留 Logo（手機也只顯示這個） -->
      <NuxtLink to="/" class="logo" aria-label="暖心e證通首頁">
        <span class="logo-mark" aria-hidden="true"></span>
        <strong class="logo-text">暖心e證通</strong>
      </NuxtLink>

      <!-- 桌機分頁 -->
      <NuxtLink
        to="/"
        class="tab"
        :class="{ active: isActive('/') }"
        :aria-current="isActive('/') ? 'page' : undefined"
      >
        申領<span></span>
      </NuxtLink>

      <NuxtLink
        to="/verify"
        class="tab"
        :class="{ active: isActive('/verify') }"
        :aria-current="isActive('/verify') ? 'page' : undefined"
      >
        驗證<span></span>
      </NuxtLink>

      <NuxtLink
        to="/admin"
        class="tab"
        :class="{ active: isAdminActive }"
        :aria-current="isAdminActive ? 'page' : undefined"
      >
        後台<span></span>
      </NuxtLink>

      <NuxtLink
        to="/docs"
        class="tab"
        :class="{ active: isActive('/docs') }"
        :aria-current="isActive('/docs') ? 'page' : undefined"
      >
        文件<span></span>
      </NuxtLink>

      <!-- 手機選單按鈕（只在手機顯示） -->
      <button
        class="menu-btn"
        :aria-expanded="mobileOpen ? 'true' : 'false'"
        aria-label="切換選單"
        @click="mobileOpen = !mobileOpen"
      >
        <span class="menu-icon"></span>
      </button>
    </div>

    <!-- 手機下拉選單 -->
    <nav v-show="mobileOpen" class="mobile" @click.self="mobileOpen = false">
      <NuxtLink to="/" class="tab" @click="mobileOpen = false">申領<span></span></NuxtLink>
      <NuxtLink to="/verify" class="tab" @click="mobileOpen = false">驗證<span></span></NuxtLink>
      <NuxtLink to="/admin" class="tab" @click="mobileOpen = false">後台<span></span></NuxtLink>
      <NuxtLink to="/docs" class="tab" @click="mobileOpen = false">文件<span></span></NuxtLink>
    </nav>
  </header>
</template>

<script setup lang="ts">
import { ref, watch, computed } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()
const mobileOpen = ref(false)

const isActive = (path: string) =>
  route.path === path || route.path.startsWith(path + '/')

const isAdminActive = computed(() => route.path.startsWith('/admin'))

watch(() => route.fullPath, () => { mobileOpen.value = false })
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@600;700;800&display=swap');

/* nav-wrap 不設背景 → 更自然 */
.nav-wrap{
  /* position: sticky; */
  top: 0;
  z-index: 50;
  padding: 1.25rem 1.25rem 0.25rem;
}

.row{
  display: flex; align-items: center; flex-wrap: wrap; gap: .75rem;
  padding: .75rem;
  border-radius: calc(var(--radius) + .5rem);
  background-color: rgba(15,20,30,0.35);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
  box-shadow: inset 0 0 0 1px rgba(255,255,255,0.06), var(--shadow);
  position: relative;
}

/* Logo 區 */
.logo{
  display: inline-flex; align-items: center; gap: .6rem;
  text-decoration: none; color: var(--ink);
  padding: .4rem .6rem; margin-right: .25rem;
  border-radius: .9rem;
  border: 1px solid rgba(255,255,255,.08);
  background: linear-gradient(180deg, rgba(255,255,255,.06), rgba(255,255,255,.02));
}
.logo:focus-visible{ outline: none; box-shadow: var(--ring); }
.logo-mark{
  width: 28px; height: 28px; border-radius: 8px;
  background:
    conic-gradient(from 180deg at 60% 40%, rgba(134,197,214,.9), rgba(241,199,179,.8), rgba(134,197,214,.9)),
    linear-gradient(180deg, #fff, #eef4f8);
  box-shadow: inset 0 0 0 1px rgba(255,255,255,.3), 0 6px 16px rgba(134,197,214,.28);
}
.logo-text{ font-weight: 800; letter-spacing: .3px; }

/* 桌機用分頁（NuxtLink 當作按鈕） */
a.tab{
  display: inline-flex; align-items: center; justify-content: center;
  position: relative; overflow: hidden;
  padding: calc(var(--font) * 0.35) calc(var(--font) * 0.7);
  font-weight: 800; font-size: var(--font); line-height: 1;
  color: var(--ink); text-decoration: none;
  border: none; border-radius: calc(var(--font) * 0.6);
  background-color: transparent;
  box-shadow:
    inset 0 0 0 0 var(--edge-3),
    inset 0 0 0 0 var(--edge-2),
    0 0 0 var(--edge-3);
  transition: all ease .2s;
}
a.tab > span{
  height: 100%; width: 100%; position: absolute; inset: 0; display: flex;
  border-radius: calc(var(--font) * 0.6); z-index: -1; overflow: hidden;
}
a.tab > span::after{
  content: ''; position: absolute; inset: 0;
  background: linear-gradient(90deg, rgba(248,249,255,0), rgba(206,216,255,.65), rgba(248,249,255,0));
  opacity: 0; transform: translateX(-100%);
}
@keyframes borders {
  0%,100%{ border-width: calc(var(--font)*.18) calc(var(--font)*.10) calc(var(--font)*.03) calc(var(--font)*.03); }
  25%{     border-width: calc(var(--font)*.10) calc(var(--font)*.03) calc(var(--font)*.03) calc(var(--font)*.18); }
  50%{     border-width: calc(var(--font)*.03) calc(var(--font)*.03) calc(var(--font)*.18) calc(var(--font)*.10); }
  75%{     border-width: calc(var(--font)*.03) calc(var(--font)*.18) calc(var(--font)*.10) calc(var(--font)*.03); }
}
a.tab::before{
  content: ''; position: absolute; inset: -4%; border-radius: calc(var(--font)*.9);
  background-color: transparent;
}
a.tab:hover{
  box-shadow:
    inset 0 0 0 calc(var(--font) * 0.18) var(--edge-3),
    inset 0 0 calc(var(--font) * 0.18) calc(var(--font) * 0.5) var(--edge-2),
    0 0 calc(var(--font) * 0.15) var(--edge-3);
}
a.tab:hover::before{
  border: solid var(--edge-1);
  padding: calc(var(--font) * .06);
  box-shadow: inset 0 0 calc(var(--font)*.18) calc(var(--font)*.18) var(--edge-2);
  filter: blur(calc(var(--font) * .05));
  animation: borders infinite 1.8s linear;
  opacity: .5;
}
a.tab:hover > span::after{
  opacity: 1; transform: translateX(100%); transition: all ease 1s;
}
a.tab.active{
  color: #0f172a;
  background: #f7fbff;
  box-shadow:
    0 8px 24px rgba(186,201,255,.25),
    inset 0 0 0 2px rgba(186,201,255,.45);
}

/* 手機漢堡：桌機隱藏、手機顯示 */
.menu-btn{
  margin-left: auto;
  display: none; /* default 隱藏，手機才顯示 */
  align-items: center; justify-content: center;
  width: 42px; height: 42px; border-radius: 12px; border: 0;
  background: rgba(255,255,255,.08);
  backdrop-filter: blur(8px);
  color: var(--ink); cursor: pointer;
}
.menu-btn:focus-visible{ outline: none; box-shadow: var(--ring); }
.menu-icon{
  position: relative; width: 20px; height: 2px; background: var(--ink);
}
.menu-icon::before, .menu-icon::after{
  content: ''; position: absolute; left: 0; right: 0; height: 2px; background: var(--ink);
}
.menu-icon::before{ top: -6px; } .menu-icon::after{ top: 6px; }

/* 手機下拉面板：桌機不顯示；手機展開成 grid */
.mobile{
  margin-top: .6rem;
  display: none;
  gap: .6rem;
  padding: .6rem;
  border-radius: var(--radius);
  background-color: rgba(15, 20, 30, 0.45);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  box-shadow: var(--shadow);
}

/* ====== 手機規則 ====== */
@media (max-width: 980px){
  :root { --font: 1.05rem; }

  /* 只留 Logo，其餘分頁全部隱藏到選單裡 */
  .row > a.tab{ display: none; }

  /* 顯示漢堡鍵，使用下拉選單承載連結 */
  .menu-btn{ display: inline-flex; }

  /* 下拉選單以 grid 呈現 */
  .mobile{ display: grid; }
}
@media (max-width: 720px){
  :root { --font: .95rem; }
  /* .logo-text{ display: none; }  */
}
</style>
