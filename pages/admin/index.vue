<template>
  <main 
    class="admin-home" 
    role="main" 
    aria-labelledby="admin-home-title"
    :style="{
      '--page-theme-color': '#b06a5b',
      '--page-theme-color-gradient': '#c7897d',
      '--page-theme-rgb': '176, 106, 91',

      '--theme-card1-color': '#4a85a0',
      '--theme-card1-rgb': '74, 133, 160',
      '--theme-card1-gradient': '#73a9c2',
      '--theme-card1-light': '#eef3f5',

      '--theme-card2-color': '#5e968c',
      '--theme-card2-rgb': '94, 150, 140',
      '--theme-card2-gradient': '#87b8af',
      '--theme-card2-light': '#eef5f4',

      '--theme-card3-color': '#9a6d8f',
      '--theme-card3-rgb': '154, 109, 143',
      '--theme-card3-gradient': '#bba0b5',
      '--theme-card3-light': '#f5f0f4'
    }"
  >
    <header class="page-header fade-slide">
      <div class="title-row">
        <h1 id="admin-home-title" class="page-title">
          <span class="title-icon" aria-hidden="true">
            <svg viewBox="0 0 24 24" width="22" height="22" fill="currentColor">
              <path d="M12 2l7 3v6c0 5-3.4 9.7-7 11-3.6-1.3-7-6-7-11V5l7-3z"></path>
            </svg>
          </span>
          暖心 e 證通 控制中心
        </h1>

        <nav class="quick-nav" aria-label="快速入口">
          <NuxtLink to="/admin/templates" class="chip-link">
            <span class="chip-icon" aria-hidden="true">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor">
                <path d="M4 4h16v2H4zM4 18h16v2H4zM4 9h16v6H4z"></path>
              </svg>
            </span>
            社福管理模擬
          </NuxtLink>
          <NuxtLink to="/admin/logs/issuance" class="chip-link">
            <span class="chip-icon" aria-hidden="true">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor">
                <path d="M12 1l3 5 5 .8-3.6 3.7.9 5.2-5.3-2.8-5.3 2.8.9-5.2L4 6.8 9 6z"></path>
              </svg>
            </span>
            憑證簽發追蹤
          </NuxtLink>
          <NuxtLink to="/admin/logs/verification" class="chip-link">
            <span class="chip-icon" aria-hidden="true">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor">
                <path d="M10 17l-4-4 1.4-1.4L10 14.2l6.6-6.6L18 9z"></path>
              </svg>
            </span>
            驗證足跡
          </NuxtLink>
        </nav>
      </div>

      <p class="page-intro">
        歡迎來到系統後台。這裡是「數位憑證卡片工廠」與「社福資料總覽」的中樞。<br />
        在這裡，我們能一目了然地看到整個流程——從民眾的身份資料，到憑證發行，再到實際被使用的情況。
      </p>

      <h3 class="page-subtitle">你可以在這裡做三件事：</h3>
      <ul class="page-highlights">
        <li><strong>社福管理系統模擬：</strong>整合各類社福身份與人口資料，觀察導入後的使用情境與普及率。</li>
        <li><strong>憑證簽發追蹤：</strong>查看每張憑證從申請、核發到領取的全流程紀錄。</li>
        <li><strong>現場驗證與使用足跡：</strong>了解民眾在哪些場域、什麼情境下使用了憑證。</li>
      </ul>
    </header>

    <section class="admin-sections">
      <article class="admin-card fade-in" style="
        --delay: 0.1s;
        --theme-color: var(--theme-card1-color);
        --theme-color-gradient: var(--theme-card1-gradient);
        --theme-rgb: var(--theme-card1-rgb);
      ">
        <header class="card-header">
          <span class="card-icon" aria-hidden="true">
            <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor">
              <path d="M12 12a5 5 0 10-5-5 5 5 0 005 5zm-9 9a9 9 0 0118 0z"></path>
            </svg>
          </span>
          <h2 class="card-title">社福管理系統模擬（身份別 × 人口總覽）</h2>
        </header>
        <div class="card-body">
          <p>
            這一頁模擬社會局在審核系統裡看到的畫面。<br />
            可以快速掌握各類社福身份的總人數、已領取、未領取狀況，並查看模擬名冊資料，例如姓名、身分證號、戶籍、家庭成員、收入來源、比對摘要等。<br />
            這能幫助你了解數位憑證導入之後，整體服務的覆蓋率與推動狀況。
          </p>
        </div>
        <footer class="card-footer">
          <NuxtLink class="card-cta" to="/admin/templates">
            前往社福管理系統模擬
          </NuxtLink>
        </footer>
      </article>

      <article class="admin-card fade-in" style="
        --delay: 0.25s;
        --theme-color: var(--theme-card2-color);
        --theme-color-gradient: var(--theme-card2-gradient);
        --theme-rgb: var(--theme-card2-rgb);
      ">
        <header class="card-header">
          <span class="card-icon" aria-hidden="true">
            <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor">
              <path d="M8 21h8v-2H8v2zM12 2l3 6h6l-4.5 4 1.5 7L12 16l-6 3 1.5-7L3 8h6z"></path>
            </svg>
          </span>
          <h2 class="card-title">憑證簽發追蹤（Issuance）</h2>
        </header>
        <div class="card-body">
          <p>
            這一頁記錄了每張憑證從申請 → 核發 → 領取的完整歷程。<br />
            你可以看到申領時間、福利種類、地區、狀態變化等細節，用來協助稽核流程、監控發卡進度，或作為政策分析的依據。
          </p>
          <h4>例如：</h4>
          <ul>
            <li><strong>稽核追溯：</strong>比對憑證狀態與操作紀錄，確認流程正確。</li>
            <li><strong>即時監控：</strong>掌握不同地區、不同身份別的發卡狀況。</li>
            <li><strong>成效評估：</strong>觀察整體普及率與使用率的變化。</li>
          </ul>
        </div>
        <footer class="card-footer">
          <NuxtLink class="card-cta" to="/admin/logs/issuance">
            前往憑證簽發追蹤
          </NuxtLink>
        </footer>
      </article>

      <article class="admin-card fade-in" style="
        --delay: 0.4s;
        --theme-color: var(--theme-card3-color);
        --theme-color-gradient: var(--theme-card3-gradient);
        --theme-rgb: var(--theme-card3-rgb);
      ">
        <header class="card-header">
          <span class="card-icon" aria-hidden="true">
            <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor">
              <path d="M12 2l9 4v6c0 5-4 9-9 10-5-1-9-5-9-10V6l9-4zm-1 13l-3-3 1.4-1.4 1.6 1.6 4.6-4.6L17 9l-6 6z"></path>
            </svg>
          </span>
          <h2 class="card-title">現場驗證與使用足跡（Verification）</h2>
        </header>
        <div class="card-body">
          <p>
            這一頁彙整了所有「掃描與驗證」的紀錄。<br />
            你可以看到驗證的時間、機構、目的、結果，了解民眾實際在哪些場景使用了數位憑證。<br />
            透過這些資料，可以看見真正的需求熱點，也能幫助社福單位與醫療、慈善、長照機構之間的協作更順暢。
          </p>
          <h4>例如：</h4>
          <ul>
            <li><strong>需求洞察：</strong>分析驗證頻率與目的，了解服務使用情形。</li>
            <li><strong>跨機構整合：</strong>各單位可匿名回傳紀錄，用於服務優化。</li>
            <li><strong>減輕民眾負擔：</strong>以數位驗證取代紙本文件，少跑一趟。</li>
          </ul>
        </div>
        <footer class="card-footer">
          <NuxtLink class="card-cta" to="/admin/logs/verification">
            前往現場驗證與使用足跡
          </NuxtLink>
        </footer>
      </article>
    </section>

    <footer class="page-footer fade-slide">
      <blockquote class="note">
        ※ 本系統所顯示之資料均為模擬內容，僅用於示範數位憑證導入與社福應用之概念設計。<br />
        實務上將遵循個資保護、最小揭露與授權查閱原則。
      </blockquote>
    </footer>
  </main>
</template>

<style scoped>
/*
 * 【CSS 修改】
 * 1. .quick-nav / .chip-link / .chip-icon：
 * - 移除原本 hard-coded 的 page-theme hover 效果
 * - 新增 [to="..."] 屬性選擇器，讓 chip 套用對應的卡片主題色
 * 2. 其他 .card-... 相關樣式：
 * - 維持不變，它們會自動繼承在 <article> 上設定的 --theme-color 變數
 */

.admin-home {
  color: #2b2b2b;
  padding: 2rem 1.5rem 3rem;
  line-height: 1.7;
  overflow-x: hidden;
}

/* ------- Header ------- */
.page-header { margin-bottom: 2.25rem; }
.title-row {
  display: flex; gap: 0.75rem; align-items: center; justify-content: space-between; flex-wrap: wrap;
}
.page-title {
  display: inline-flex; align-items: center; gap: 0.5rem;
  font-size: 1.9rem; font-weight: 700;
  color: var(--page-theme-color, #d27b4b);
  letter-spacing: 0.2px; margin: 0;
}
.title-icon { 
  display: inline-flex; 
  color: var(--page-theme-color, #c96c3b); 
}

/* 【修改】 quick-nav 樣式 */
.quick-nav { display: flex; gap: 0.5rem; flex-wrap: wrap; }
.chip-link {
  display: inline-flex; align-items: center; gap: 0.4rem;
  border: 1px solid #e0dcd7; 
  background: #fff; 
  color: #5a4e47;
  border-radius: 999px; padding: 0.4rem 0.75rem; text-decoration: none; font-size: 0.92rem;
  transition: transform .2s ease, box-shadow .2s ease, border-color .2s ease, background-color .2s ease, color .2s ease;
}
.chip-icon {
  display: inline-flex;
  /* 讓 icon 顏色繼承 .chip-link 的 color */
  color: currentColor; 
  opacity: 0.8;
}

/* 【新增】為三個連結分別上色 */
.chip-link[to="/admin/templates"] {
  background-color: var(--theme-card1-light, #eef3f5);
  border-color: rgba(var(--theme-card1-rgb, 74, 133, 160), 0.2);
  color: var(--theme-card1-color, #4a85a0);
}
.chip-link[to="/admin/logs/issuance"] {
  background-color: var(--theme-card2-light, #eef5f4);
  border-color: rgba(var(--theme-card2-rgb, 94, 150, 140), 0.2);
  color: var(--theme-card2-color, #5e968c);
}
.chip-link[to="/admin/logs/verification"] {
  background-color: var(--theme-card3-light, #f5f0f4);
  border-color: rgba(var(--theme-card3-rgb, 154, 109, 143), 0.2);
  color: var(--theme-card3-color, #9a6d8f);
}

/* 【修改】Hover 效果改為使用各自的顏色 */
.chip-link {
  /* ... (其他樣式) ... */
  transform: translateY(0); /* 確保 base state */
}
.chip-link:hover {
  transform: translateY(-2px); 
}
.chip-link[to="/admin/templates"]:hover {
  box-shadow: 0 6px 14px rgba(var(--theme-card1-rgb, 74, 133, 160), .16);
  border-color: rgba(var(--theme-card1-rgb, 74, 133, 160), 0.3);
}
.chip-link[to="/admin/logs/issuance"]:hover {
  box-shadow: 0 6px 14px rgba(var(--theme-card2-rgb, 94, 150, 140), .16);
  border-color: rgba(var(--theme-card2-rgb, 94, 150, 140), 0.3);
}
.chip-link[to="/admin/logs/verification"]:hover {
  box-shadow: 0 6px 14px rgba(var(--theme-card3-rgb, 154, 109, 143), .16);
  border-color: rgba(var(--theme-card3-rgb, 154, 109, 143), 0.3);
}


.page-intro { font-size: 1.05rem; margin: 0.85rem 0 0.75rem; color: #3a3a3a; }
.page-highlights { list-style: none; padding: 0; margin: 0.25rem 0 0; }
.page-highlights li {
  display: flex; align-items: flex-start; gap: 0.5rem;
  margin: 0.35rem 0; color: #3f3f3f;
}

/* ------- Cards (此區樣式不需變動) ------- */
.admin-sections { display: grid; gap: 1.6rem; margin-top: 1rem; }
.admin-card {
  position: relative; overflow: hidden;
  background: #fff; border-radius: 14px; border: 1px solid #e0dcd7;
  padding: 1.5rem 1.75rem;
  box-shadow: 0 4px 10px rgba(0,0,0,.05);
  transition: transform .35s cubic-bezier(.25,.1,.25,1), box-shadow .35s cubic-bezier(.25,.1,.25,1), border-color .35s;
}
.admin-card::after {
  content: ""; position: absolute; inset: 0;
  background: radial-gradient(circle at 60% 120%, rgba(var(--theme-rgb, 210, 123, 75),.08), transparent 65%);
  opacity: 0; transition: opacity .35s ease;
  pointer-events: none;
}
.admin-card:hover { 
  transform: translateY(-4px); 
  box-shadow: 0 10px 22px rgba(var(--theme-rgb, 210, 123, 75),.18); 
  border-color: rgba(var(--theme-rgb, 210, 123, 75), 0.2); 
}
.admin-card:hover::after { opacity: 1; }

.card-header { display: flex; align-items: center; gap: .6rem; margin-bottom: .5rem; }
.card-icon { 
  display: inline-flex; 
  color: var(--theme-color, #c96c3b); 
}
.card-title { 
  font-size: 1.24rem; font-weight: 600; 
  color: var(--theme-color, #c96c3b); 
  margin: 0; 
}

.card-body p { margin-bottom: .7rem; color: #2b2b2b; }
.card-body ul { margin: .5rem 0 0 1.25rem; color: #444; }

.card-footer { margin-top: 1rem; display: flex; flex-wrap: wrap; gap: .5rem; }

/* ------- CTA Button (此區樣式不需變動) ------- */
.card-cta {
  position: relative; z-index: 1;
  display: inline-flex; align-items: center; gap: .5rem;
  background: linear-gradient(135deg, var(--theme-color, #d27b4b), var(--theme-color-gradient, #e7b17d));
  color: #fff; padding: .56rem 1.1rem; border-radius: 9px; text-decoration: none;
  font-weight: 500; letter-spacing: .2px;
  box-shadow: 0 2px 6px rgba(var(--theme-rgb, 210,123,75),.2);
  transition: transform .25s ease, box-shadow .25s ease, filter .25s ease;
}
.card-cta:hover { 
  transform: translateY(-1px) scale(1.015); 
  box-shadow: 0 6px 14px rgba(var(--theme-rgb, 210,123,75),.28); 
  filter: saturate(1.05); 
}
.card-cta:focus-visible { 
  outline: 3px solid rgba(var(--theme-rgb, 210, 123, 75), 0.4); 
  outline-offset: 2px; 
}

/* ------- Footer (無變動) ------- */
.page-footer { margin-top: 2rem; text-align: center; color: #666; font-size: .9rem; }

/* ------- Animations (無變動) ------- */
.fade-in { opacity: 0; transform: translateY(16px); animation: fadeInUp .7s forwards; animation-delay: var(--delay,0s); }
.fade-slide { opacity: 0; transform: translateY(-12px); animation: fadeSlideDown .8s forwards; }

@keyframes fadeInUp { to { opacity: 1; transform: translateY(0); } }
@keyframes fadeSlideDown { to { opacity: 1; transform: translateY(0); } }

/* ------- RWD (無變動) ------- */
@media (max-width: 768px) {
  .admin-home { padding: 1.25rem; }
  .page-title { font-size: 1.55rem; }
  .admin-card { padding: 1.25rem; }
}
</style>