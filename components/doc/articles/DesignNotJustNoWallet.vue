<!-- components/doc/articles/DesignNotJustNoWallet.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '數位憑證是不是只是「不帶證件出門」的炫技？',
  subtitle: '設計理念篇 / 信任協定 × 風險轉移 × 最小揭露',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '設計理念篇', to: '/docs#philo' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- 一、誤解的起點 -->
      <section class="lead">
        <h2 id="s1">一、誤解的起點：數位 ≠ 方便而已</h2>
        <p>
          初次聽到「數位憑證」，多半會以為只是把證件放進手機裡、少帶一張卡。
          但若只是電子化卡面，它充其量是便利工具，並非對<strong>信任架構</strong>的革新。
        </p>
        <p>
          真正的重點，是讓每一次「確認身分」的過程更安全、更尊重、更去中心化。
        </p>
      </section>

      <hr class="div" />

      <!-- 二、「不帶證件出門」的邊界 -->
      <section>
        <h2 id="s2">二、「不帶證件出門」能解決什麼？也有什麼解決不了？</h2>
        <p>
          對一般人，「手機裡什麼都有」很吸引人（交通票證、登機證、就醫識別…）。但把憑證視為「電子條碼」仍有侷限：
        </p>
        <ul class="bullets">
          <li><strong>中心依賴：</strong>伺服器當機或斷線就無法驗證。</li>
          <li><strong>過度揭露：</strong>掃描即顯示完整個資，無法細緻授權。</li>
          <li><strong>驗證不可攜：</strong>此處驗過，彼處無法重用結果。</li>
        </ul>
        <p>這些是可驗證憑證（VC）試圖根本解的問題。</p>
      </section>

      <hr class="div" />

      <!-- 三、VC 的本質 -->
      <section>
        <h2 id="s3">三、數位憑證的本質：重新設計「信任」的流程</h2>
        <p>
          可驗證憑證（Verifiable Credential, VC）不是檔案格式，而是一種<strong>信任協定</strong>，把「證明真實性」與「揭露內容」分離：
        </p>

        <div class="table-wrap">
          <table class="cmp">
            <thead>
              <tr><th scope="col">傳統電子證件</th><th scope="col">可驗證憑證（VC）</th></tr>
            </thead>
            <tbody>
              <tr><td>顯示資料 → 由對方判斷真假</td><td>不顯示內容 → 由簽章驗真偽</td></tr>
              <tr><td>每次都要連線查庫</td><td>可離線驗證（僅需公鑰）</td></tr>
              <tr><td>一次揭露所有欄位</td><td>可<strong>選擇性揭露</strong>必要欄位</td></tr>
              <tr><td>驗證結果無法重用</td><td>驗證結果可重組、跨平台流通</td></tr>
            </tbody>
          </table>
        </div>

        <div class="callout">
          <p><strong>設計要點：</strong>讓「身份可被驗證」，而不必「身份被攤開」。</p>
        </div>
      </section>

      <hr class="div" />

      <!-- 四、不是炫技，而是風險重新分配 -->
      <section>
        <h2 id="s4">四、不是炫技，而是轉移風險</h2>
        <p>視覺上看似一樣的「掃一下」，底層風險卻完全不同：</p>
        <div class="grid2">
          <article class="card">
            <h3>傳統模式</h3>
            <ul class="tick">
              <li>資料集中在單一庫，查驗風險集中。</li>
              <li>每次查驗都可能留下完整可識別紀錄。</li>
              <li>系統越集中越脆弱。</li>
            </ul>
          </article>
          <article class="card">
            <h3>VC 模式</h3>
            <ul class="tick">
              <li>資料分散於個人端，由持有人授權。</li>
              <li>可匿名或去識別驗證，降低過度留痕。</li>
              <li>去中心化提升韌性與彈性。</li>
            </ul>
          </article>
        </div>
      </section>

      <hr class="div" />

      <!-- 五、副產品與核心 -->
      <section>
        <h2 id="s5">五、「不帶證件出門」只是副產品</h2>
        <p>VC 帶來的核心不是炫技，而是把每次驗證行為變得：</p>
        <div class="kpi-row" role="list">
          <div class="kpi" role="listitem"><span class="kpi-label">可信度</span><span class="kpi-val up">↑</span></div>
          <div class="kpi" role="listitem"><span class="kpi-label">可控性</span><span class="kpi-val up">↑</span></div>
          <div class="kpi" role="listitem"><span class="kpi-label">過度揭露</span><span class="kpi-val">↓</span></div>
        </div>
        <ul class="bullets">
          <li><strong>更可信：</strong>以簽章為信任基礎，而非螢幕截圖或影本。</li>
          <li><strong>更可控：</strong>由持有人選擇揭露哪幾個欄位。</li>
          <li><strong>更尊重：</strong>最小揭露，避免不必要的標籤與歧視。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 六、小結 -->
      <section class="quote">
        <h2 id="s6">六、小結：讓信任可被攜帶</h2>
        <p>
          數位憑證不是「更漂亮的卡」，而是讓信任在多個場域中可被攜帶、可被驗證、可被撤銷。
          當我們能被即時、準確、有限地驗證，數位便利才真正落地——那是一種由信任而生的自由。
        </p>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post{
  --c-ink:#2b2b2b;
  --c-muted:#5a4e47;
  --c-primary:#b35f37;
  --c-accent:#e4b17c;
  --c-soft:#fff8f2;
  --c-surface:#fff;
  --c-line:#ead8c8;
  color:var(--c-ink);
  line-height:1.8;
}

/* 標題 */
.post h2{
  margin:1.12rem 0 .55rem;
  font-size:1.12rem;
  color:var(--c-primary);
  display:inline-flex;align-items:center;gap:.45rem;
}
.post h2::before{
  content:"";
  width:10px;height:10px;border-radius:50%;
  background:radial-gradient(circle at 40% 40%,var(--c-accent),var(--c-primary));
  display:inline-block;
}

/* 導言 */
.lead{
  background:linear-gradient(180deg,#fffdf9,var(--c-soft));
  border:1px solid #f0e1d8;border-radius:12px;
  padding:.9rem 1rem;
}

/* 文字與列表 */
.post p{margin:.35rem 0 .75rem}
.bullets{margin:.35rem 0 .9rem 1.25rem}
.bullets li{margin:.22rem 0}

/* 視覺分隔線 */
.div{
  border:0;height:1px;
  background:linear-gradient(90deg,#f0e6df,var(--c-line) 40%,#f0e6df);
  margin:1rem 0 1rem
}

/* 表格 */
.table-wrap{overflow-x:auto;border:1px solid #efe6de;border-radius:12px;background:#fff}
.cmp{width:100%;min-width:520px;border-collapse:collapse}
.cmp thead th{
  text-align:left;font-weight:700;font-size:.92rem;color:#835b46;
  background:#fff7f0;border-bottom:1px solid var(--c-line);padding:.55rem .7rem
}
.cmp tbody td{padding:.55rem .7rem;border-bottom:1px solid #f2e7dd}
.cmp tbody tr:last-child td{border-bottom:0}

/* 兩欄卡片 */
.grid2{
  display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
  gap:.85rem;margin-top:.35rem
}
.card{
  background:var(--c-surface);border:1px solid #e8e0d9;border-radius:12px;
  padding:.8rem .95rem;box-shadow:0 2px 6px rgba(0,0,0,.04);
  transition:transform .2s ease,box-shadow .2s ease,border-color .2s ease
}
.card:hover{transform:translateY(-2px);border-color:#d27b4b33;box-shadow:0 8px 18px rgba(210,123,75,.14)}
.card h3{margin:0 0 .35rem;color:#b35f37;font-size:1rem}

/* 勾選式清單 */
.tick{margin:.35rem 0 .9rem 1.25rem}
.tick li{list-style:none;position:relative;padding-left:1.25rem;margin:.22rem 0}
.tick li::before{content:"✔";position:absolute;left:0;top:.1rem;color:var(--c-primary)}

/* KPI 小徽章列 */
.kpi-row{display:flex;flex-wrap:wrap;gap:.5rem;margin:.4rem 0 .2rem}
.kpi{
  display:flex;align-items:center;gap:.45rem;
  border:1px solid #e8e0d9;border-radius:999px;
  background:#fff;padding:.25rem .6rem;box-shadow:0 2px 6px rgba(0,0,0,.04)
}
.kpi-label{font-size:.82rem;color:#8b6a56}
.kpi-val{font-weight:800;color:#9b3b2a}
.kpi-val.up{color:#2a7a55}

/* Callout / 引文 */
.callout{
  border-left:4px solid var(--c-primary);
  background:linear-gradient(180deg,#fffdf9,var(--c-soft));
  padding:.75rem .9rem;border-radius:10px;margin-top:.45rem
}
.quote{
  background:#fff;border:1px solid #e8e0d9;border-radius:12px;
  padding:.85rem 1rem;color:#583d30;box-shadow:0 2px 6px rgba(0,0,0,.04)
}

/* * RWD 設定
 * 當螢幕寬度小於等於 768px 時套用
 */
@media (max-width: 768px) {
  /* 縮小標題字體 */
  .post h2 {
    font-size: 1.06rem;
  }

  /* 調整區塊邊距 */
  .lead {
    padding: .8rem;
  }
  .callout,
  .quote {
    padding: .75rem .9rem;
  }

  /* 縮小清單的左側空間 */
  .bullets {
    margin-left: 1rem;
  }
  .tick {
    margin-left: .5rem;
    padding-left: 1.1rem; /* 仍需足夠空間放 '✔' */
  }

  /* 使表格在小螢幕滾動時更緊湊 */
  .cmp thead th,
  .cmp tbody td {
    padding: .45rem .5rem; /* 減少儲存格 padding */
    font-size: .9rem;      /* 統一字體大小 */
    line-height: 1.5;
  }
  .cmp thead th {
    font-size: .85rem; /* 標頭字再小一點 */
  }

  /* 讓 KPI 徽章換行時置中 */
  .kpi-row {
    justify-content: center;
  }

  /* 2 欄網格的 `auto-fit` 會自動處理換行，
     我們只需微調間距即可 */
  .grid2 {
    gap: .6rem;
  }
}
</style>