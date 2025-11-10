<script setup lang="ts">
type DocItem = { title: string; slug: string };
type DocCategory = {
  key: string;
  title: string;
  icon: 'field' | 'philo' | 'policy' | 'user' | 'future';
  summary: string;
  items: DocItem[];
  color: string;
  colorLight: string;
  colorRGB: string;
};

// 【修改】更換為低飽和度、更有質感的色系
const categories: DocCategory[] = [
  {
    key: 'field',
    title: '一、現場應用篇：為什麼要在第一線導入數位憑證？',
    icon: 'field',
    summary: '聚焦真實現場情境：社區訪查、災害應變、物資發放、醫院補助申請。探討「驗證」如何反映資源分配與使用成效。',
    items: [
      { title: '為什麼里長或里幹事需要一個能掃的「數位身份」？', slug: 'field-why-local-id' },
      { title: '在災害現場，社福身份能如何幫助快速辨識？', slug: 'field-disaster-id' },
      { title: '若善心機構拿不到社福名冊，數位憑證能解決什麼？', slug: 'field-no-roster' },
      { title: '驗證頻率代表什麼？能否反映社會資源的實際使用率？', slug: 'field-frequency-meaning' },
      { title: '如果驗證頻率過低，代表這個憑證沒有價值嗎？', slug: 'field-low-frequency' }
    ],
    color: '#4a85a0', // 霧霾藍
    colorLight: '#eef3f5',
    colorRGB: '74, 133, 160'
  },
  {
    key: 'philo',
    title: '二、設計理念篇：數位憑證能、該、與不該做什麼？',
    icon: 'philo',
    summary: '討論數位憑證的應用邊界與設計哲學；不同情境需要不同的隱私強度。',
    items: [
      { title: '為什麼社福身份憑證這麼敏感，卻又非做不可？', slug: 'design-sensitive-but-needed' },
      { title: '數位憑證是不是只是「不帶證件出門」的炫技？', slug: 'design-not-just-no-wallet' },
      { title: '折價券、票券、房卡也要用 VC 嗎？什麼情境才「值得」？', slug: 'design-when-vc-worth' },
      { title: '零知識證明是關於隱私還是信任？誰需要、誰其實不需要？', slug: 'design-zkp-privacy-trust' },
      { title: '現行身障證明揭露太多個資時，如何用選擇性揭露修正？', slug: 'design-sd-jwt-accessibility' }
    ],
    color: '#9a6d8f', // 藕荷紫
    colorLight: '#f5f0f4',
    colorRGB: '154, 109, 143'
  },
  {
    key: 'policy',
    title: '三、技術與政策篇：如何讓數位憑證在現實中落地？',
    icon: 'policy',
    summary: '從架構、權限到審計流程探討落地條件；並評估成本與政策層的信任機制（第三方驗證、可追蹤性）。',
    items: [
      { title: '為什麼社會福利資格會頻繁變動？這對數位憑證代表什麼挑戰？', slug: 'policy-dynamic-eligibility' },
      { title: '政府資料庫能直接介接 VC 嗎？需要哪些安全防線？', slug: 'policy-government-integration' },
      { title: '憑證簽發與驗證要如何被審計？是否會增加行政負擔？', slug: 'policy-auditability' },
      { title: '醫院、長照、律師事務所導入 VC 要先克服什麼？', slug: 'policy-onboarding-sectors' },
      { title: '如何防止「偽造社福身份」或「假驗證」？', slug: 'policy-anti-fraud' }
    ],
    color: '#5e968c', // 灰豆綠
    colorLight: '#eef5f4',
    colorRGB: '94, 150, 140'
  },
  {
    key: 'user',
    title: '四、使用者觀點篇：對民眾而言，這真的有幫助嗎？',
    icon: 'user',
    summary: '回到民眾視角：信任、尊嚴與體驗，尋找創新與人性之間的平衡。',
    items: [
      { title: '為什麼我必須使用數位憑證？不能直接用健保卡、身分證嗎？', slug: 'user-why-credentials' },
      { title: '若我是長輩或行動不便者，這個 App 更方便還是更困難？', slug: 'user-accessibility' },
      { title: '我能相信這個 App 嗎？我的資料真的不會被看到嗎？', slug: 'user-trust-privacy' },
      { title: '生物識別（指紋、臉部）的角色是什麼？真的安全嗎？', slug: 'user-biometrics' }
    ],
    color: '#a0875c', // 枯金
    colorLight: '#f6f4ef',
    colorRGB: '160, 135, 92'
  },
  {
    key: 'future',
    title: '五、延伸思考篇：從社福憑證開始，接下來呢？',
    icon: 'future',
    summary: '探討 VC 在醫療、教育、慈善、災害應變、長照等領域的延伸與倫理邊界。',
    items: [
      { title: '當社福身份都能用 VC 管理後，下一個能被改變的是什麼？', slug: 'future-next-domain' },
      { title: '政府與民間如何共享這套驗證機制？', slug: 'future-public-private' },
      { title: '若開放 VC 架構給醫院、慈善團體或學校，如何防止濫用？', slug: 'future-abuse-prevention' },
      { title: '我們要如何衡量「數位信任」的成效？', slug: 'future-metrics-trust' },
      { title: '哪些數據應「被看見」，哪些應「永遠被隱藏」？', slug: 'future-visibility-ethics' }
    ],
    color: '#b06a5b', // 磚紅 (沿用原始色系，但降低飽和度)
    colorLight: '#f8f1ef',
    colorRGB: '176, 106, 91'
  }
];

function iconPath(name: DocCategory['icon']) {
  switch (name) {
    case 'field': return 'M12 2a7 7 0 017 7c0 5.25-7 13-7 13S5 14.25 5 9a7 7 0 017-7zm0 9.5A2.5 2.5 0 109.5 9 2.5 2.5 0 0012 11.5z';
    case 'philo': return 'M12 2a10 10 0 1010 10A10.011 10.011 0 0012 2zm3.9 6.1l-3.2 7.8-7.8 3.2 3.2-7.8 7.8-3.2z';
    case 'policy': return 'M12 2l9 4v6c0 6-4.5 11-9 12-4.5-1-9-6-9-12V6l9-4zM8 14h8v2H8zM8 10h8v2H8z';
    case 'user': return 'M12 12a5 5 0 10-5-5 5 5 0 005 5zm-9 9a9 9 0 0118 0z';
    case 'future': return 'M12 2l1.8 5.5L19 9l-5.2 3.5L12 18l-1.8-5.5L5 9l5.2-1.5L12 2zM6 20h12v2H6z';
  }
}
</script>
<template>
  <main class="doc-home" role="main" aria-labelledby="doc-home-title">
    <header class="page-header fade-slide">
      <h1 id="doc-home-title" class="page-title">
        <span class="title-icon" aria-hidden="true">
          <svg viewBox="0 0 24 24" width="22" height="22" fill="currentColor">
            <path d="M4 3h12a3 3 0 013 3v13a2 2 0 01-2 2H6a2 2 0 01-2-2V3zM8 7h8v2H8zM8 11h8v2H8zM8 15h8v2H8z"></path>
          </svg>
        </span>
        暖心 e 證通 文件中心
      </h1>

      <p class="page-intro">
        這裡是「暖心 e 證通」的專案文件入口，彙整從構想到技術實作的完整思考歷程。<br />
        每篇文件都以「提問」開場，從真實場景與使用者困境出發，探討數位憑證在社福應用中的價值、挑戰與界線。<br />
        這些文件不只是技術報告，更像一系列關於公共服務數位轉型的故事。
      </p>
    </header>

    <section class="doc-section-list" aria-label="文件主題總覽">
      <article 
        v-for="(cat, index) in categories" 
        :key="cat.key" 
        class="cat-card fade-in" 
        :style="{
          '--delay': `${index * 0.07 + 0.1}s`,
          '--theme-color': cat.color,
          '--theme-color-light': cat.colorLight,
          '--theme-color-rgb': cat.colorRGB
        }"
      >
        <header class="cat-header">
          <span class="cat-icon" aria-hidden="true">
            <svg viewBox="0 0 24 24" width="20" height="20" fill="currentColor">
              <path :d="iconPath(cat.icon)"></path>
            </svg>
          </span>
          <h2 class="cat-title">{{ cat.title }}</h2>
        </header>

        <p class="cat-summary">{{ cat.summary }}</p>

        <ul class="doc-grid" role="list">
          <li v-for="doc in cat.items" :key="doc.slug" class="doc-card">
            <NuxtLink :to="`/docs/${doc.slug}`" class="doc-link" :aria-label="`開啟：${doc.title}`">
              <span class="q-mark" aria-hidden="true">?</span>
              <span class="doc-title">{{ doc.title }}</span>
              <span class="doc-arrow" aria-hidden="true">
                <svg viewBox="0 0 24 24" width="18" height="18" fill="currentColor">
                  <path d="M5 12h14M13 5l7 7-7 7"></path>
                </svg>
              </span>
            </NuxtLink>
          </li>
        </ul>
      </article>
    </section>

    <footer class="page-footer fade-slide">
      <blockquote class="note">
        ※ 所有文件內容均以「暖心 e 證通」競賽構想為基礎，用於說明公民科技在社福應用的可行性與反思方向。未涉及真實個資或真實機關資料。
      </blockquote>
    </footer>
  </main>
</template>

<style scoped>
/* 基本樣式 (無變動) */
.doc-home {
  color: #2b2b2b;
  padding: 2rem 1.5rem 3rem;
  line-height: 1.7;
  overflow-x: hidden;
}
.page-header {
  margin-bottom: 1.5rem;
}
.page-title {
  display: inline-flex;
  align-items: center;
  gap: .5rem;
  font-size: 1.85rem;
  font-weight: 700;
  color: #d27b4b;
  letter-spacing: .2px;
  margin: 0;
}
.title-icon {
  color: #c96c3b;
}
.page-intro {
  font-size: 1.03rem;
  margin: .75rem 0 0;
  color: #3a3a3a;
}

/* * 【CSS 修改】
 * 以下將 #c96c3b, #f3e2d5, #b35f37, rgba(210,123,75,...)
 * 等寫死的顏色，全部替換為 CSS 變數。
 * var(--variable, fallback) 語法確保在變數失效時，仍有預設的橘色。
 */

/* 分類卡片 */
.cat-card {
  position: relative;
  overflow: hidden;
  background: #fff;
  border-radius: 14px;
  border: 1px solid #e0dcd7;
  padding: 1.25rem 1.5rem;
  margin-top: 1rem;
  box-shadow: 0 4px 10px rgba(0,0,0,.05);
  transition: transform .3s cubic-bezier(.25,.1,.25,1), box-shadow .3s cubic-bezier(.25,.1,.25,1), border-color .3s;
}
.cat-card:hover {
  transform: translateY(-2px);
  /* 【修改】使用 --theme-color-rgb */
  box-shadow: 0 10px 22px rgba(var(--theme-color-rgb, 210, 123, 75), .12);
  /* 【修改】使用 --theme-color-rgb (0.2 approx 33) */
  border-color: rgba(var(--theme-color-rgb, 210, 123, 75), 0.2); 
}
.cat-header {
  display: flex;
  align-items: center;
  gap: .6rem;
  margin-bottom: .25rem;
}
.cat-icon {
  /* 【修改】使用 --theme-color */
  color: var(--theme-color, #c96c3b);
  display: inline-flex;
}
.cat-title {
  font-size: 1.15rem;
  font-weight: 600;
  /* 【修改】使用 --theme-color */
  color: var(--theme-color, #c96c3b);
  margin: 0;
}
.cat-summary {
  margin: .35rem 0 .8rem;
  color: #5a4e47;
  font-size: .97rem;
}

/* 文件連結網格 */
.doc-grid {
  --min: 280px;
  display: grid;
  grid-template-columns: repeat(auto-fill, var(--min));
  justify-content: center;
  gap: .8rem;
  list-style: none;
  padding: 0;
  margin: 0;
}
.doc-card {
  border: 1px solid #e6e1db;
  border-radius: 12px;
  background: #fff;
  transition: transform .25s ease, box-shadow .25s ease, border-color .25s ease;
  box-shadow: 0 2px 6px rgba(0,0,0,.04);
  overflow: hidden;
}
.doc-link {
  position: relative;
  z-index: 1;
  display: grid;
  grid-template-columns: auto 1fr auto;
  align-items: center;
  gap: .65rem;
  padding: .9rem .95rem;
  text-decoration: none;
  color: #2b2b2b;
}
.q-mark {
  flex: 0 0 auto;
  width: 22px;
  height: 22px;
  border-radius: 50%;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  /* 【修改】使用 --theme-color-light */
  background: var(--theme-color-light, #f3e2d5);
  /* 【修改】使用 --theme-color (原 #b35f37 顏色較深，但用主題色一致性更高) */
  color: var(--theme-color, #b35f37);
  font-weight: 700;
}
.doc-title {
  line-height: 1.45;
}
.doc-arrow {
  /* 【修改】使用 --theme-color */
  color: var(--theme-color, #c96c3b);
  opacity: .9;
}
.doc-card:hover {
  transform: translateY(-2px);
  /* 【修改】使用 --theme-color-rgb */
  border-color: rgba(var(--theme-color-rgb, 210, 123, 75), 0.2);
  /* 【修改】使用 --theme-color-rgb */
  box-shadow: 0 8px 18px rgba(var(--theme-color-rgb, 210, 123, 75), .14);
}

/* 頁尾 (無變動) */
.page-footer {
  margin-top: 2rem;
  text-align: center;
  color: #666;
  font-size: .9rem;
}

/* 動畫 (無變動) */
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

/* RWD 設定 (無變動) */
@media (max-width: 768px) {
  .doc-home {
    padding: 1.5rem 0.75rem 2rem; 
  }
  .page-title {
    font-size: 1.55rem;
  }
  .page-intro {
    font-size: 1rem;
    line-height: 1.65;
  }
  .cat-card {
    padding: 1.25rem;
  }
  .cat-title {
    font-size: 1.1rem;
  }
  .cat-summary {
    font-size: .95rem;
  }
  .doc-grid {
    gap: .6rem;
  }
  .doc-link {
    padding: .8rem .9rem;
    gap: .6rem;
  }
  .doc-title {
    font-size: .95rem;
    overflow-wrap: break-word;
    min-width: 0; 
  }
}
</style>