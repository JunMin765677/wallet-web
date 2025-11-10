<!-- components/doc/articles/FieldNoRoster.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '若善心機構拿不到社福名冊，數位憑證能解決什麼？',
  subtitle: '現場應用篇 / 無名單合作 × 即時驗證 × 法遵降風險',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '現場應用篇', to: '/docs#field' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- 一、善意與制度之間的矛盾 -->
      <section>
        <h2 id="s1">一、善意與制度之間的矛盾</h2>
        <p>
          在台灣，許多善心機構、宗教團體或社區組織，長期都在協助弱勢族群。
          但他們面臨一個長年未解的難題——<strong>社會局不會提供社福名冊</strong>。
        </p>
        <p>這不是不願意合作，而是因為：</p>
        <ul>
          <li>涉及大量敏感個資（身分證號、地址、家庭狀況、收入等）；</li>
          <li>公部門受《個資保護法》與行政中立原則限制，無法將名冊外流；</li>
          <li>即使是協助發放物資的慈善機構，也只能透過民眾「自行出示證明」來核對資格。</li>
        </ul>

        <div class="problem-grid">
          <div class="pbox">
            <h3>善心機構</h3>
            <p>不知道該幫誰，容易重複發放或漏發。</p>
          </div>
          <div class="pbox">
            <h3>弱勢民眾</h3>
            <p>得自己舉證，還要跑公所打印紙本證明。</p>
          </div>
          <div class="pbox">
            <h3>服務現場</h3>
            <p>充滿摩擦，信任成本被轉嫁給最弱勢者。</p>
          </div>
        </div>
      </section>

      <hr class="div" />

      <!-- 二、數位憑證：讓問題不必靠名冊回答 -->
      <section>
        <h2 id="s2">二、數位憑證：讓「誰需要幫助」的問題不必靠名冊回答</h2>
        <p>
          數位憑證提供的並不是名單，而是一種<strong>即時驗證的能力</strong>。
          當慈善機構要發放物資時，不需要擁有資料庫，只需透過官方授權的驗證介面即可：
        </p>
        <ul class="bullets">
          <li>民眾出示自己的社福數位憑證（App 內的 QR Code）。</li>
          <li>機構掃描後，系統回傳「是否符合領取資格」。</li>
          <li>驗證結果僅顯示「通過 / 不通過」與必要備註（例如：符合低收入戶資格、有身障身分）。</li>
        </ul>
        <p>
          整個過程不揭露姓名、地址或家庭狀況，卻能確認<strong>資源正確地發放給該得到的人</strong>。
        </p>

        <blockquote class="shift">
          從「告訴我名單」<span aria-hidden="true"> → </span>「讓我能驗證真偽」。
        </blockquote>
      </section>

      <hr class="div" />

      <!-- 三、對善心機構的幫助 -->
      <section>
        <h2 id="s3">三、對善心機構的幫助</h2>
        <ul class="tick">
          <li><strong>效率提升：</strong>現場只需掃描，不需逐一檢查文件。</li>
          <li><strong>人力負擔減輕：</strong>不再依賴大量志工手動比對或記錄。</li>
          <li><strong>資源分配更精準：</strong>避免重複領取、冒領或資料造假。</li>
          <li><strong>合作更安全：</strong>機構不需存放個資，降低法律風險。</li>
          <li><strong>透明回饋：</strong>驗證次數與結果形成匿名統計，協助社會局追蹤民間資源流向。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 四、對社會局與民眾的價值 -->
      <section>
        <h2 id="s4">四、對社會局與民眾的價值</h2>
        <div class="two-col">
          <div>
            <h3>對社會局</h3>
            <ul>
              <li>掌握民間資源分配狀況，形成公共協作的資料閉環。</li>
              <li>減少紙本證明核發量，節省行政成本與審核人力。</li>
            </ul>
          </div>
          <div>
            <h3>對民眾</h3>
            <ul>
              <li>不需重複申請紙本證明。</li>
              <li>自主掌控自己的身份資訊。</li>
              <li>只要出示憑證，就能在不同機構間完成驗證與領取。</li>
            </ul>
          </div>
        </div>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
/* 專屬本篇的色系與版面（暖中性色，與其他文章互不干擾） */
.post {
  --c-primary: #b35f37;
  --c-accent: #e4b17c;
  --c-ink: #2b2b2b;
  --c-muted: #5a4e47;
  --c-surface: #fff;
  --c-soft: #fff8f2;
  color: var(--c-ink);
  line-height: 1.8;
}

/* 標題樣式 */
.post h2 {
  margin: 1.15rem 0 .55rem;
  font-size: 1.12rem;
  color: var(--c-primary);
  display: inline-flex;
  align-items: center;
  gap: .4rem;
}
.post h2::before {
  content: "";
  width: 10px; height: 10px; border-radius: 50%;
  background: radial-gradient(circle at 40% 40%, var(--c-accent), var(--c-primary));
  display: inline-block;
}
.post h3 { margin: .35rem 0 .3rem; color: var(--c-muted); font-size: 1rem; }

/* 文字與列表 */
.post p { margin: .35rem 0 .75rem; }
.post ul { margin: .3rem 0 .9rem 1.25rem; }
.post li { margin: .2rem 0; }
.post strong { color: var(--c-muted); }

/* 分隔線 */
.div {
  border: 0;
  height: 1px;
  background: linear-gradient(90deg, #f0e6df, #ead8c8 40%, #f0e6df);
  margin: 1rem 0 1rem;
}

/* 問題三欄 */
.problem-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: .75rem;
  margin: .5rem 0 .2rem;
}
.pbox {
  background: var(--c-surface);
  border: 1px solid #e8e0d9;
  border-radius: 10px;
  padding: .75rem .9rem;
  box-shadow: 0 2px 6px rgba(0,0,0,.04);
}

/* 轉念重點 */
.shift {
  margin:.7rem 0 .2rem;
  padding:.65rem .85rem;
  border-left:4px solid var(--c-primary);
  background: linear-gradient(180deg, #fffdf9, var(--c-soft));
  border-radius:8px;
  font-weight:600;
  color:#583d30;
}

/* 勾選式清單 */
.tick li { list-style: none; position: relative; padding-left: 1.25rem; }
.tick li::before {
  content: "✔"; position: absolute; left: 0; top: .1rem; font-size: .95rem; color: var(--c-primary);
}

/* 兩欄區塊 */
.two-col {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
  gap: .9rem;
}
.two-col > div {
  background: var(--c-surface);
  border: 1px solid #e8e0d9;
  border-radius: 10px;
  padding: .75rem .9rem;
}

/* 子彈點更易讀 */
.bullets li { padding-left: .2rem; }

/* RWD */
@media (max-width: 768px) {
  .post h2 { font-size: 1.06rem; }
}
</style>
