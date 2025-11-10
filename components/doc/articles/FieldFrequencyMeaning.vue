<!-- components/doc/articles/FieldFrequencyMeaning.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '驗證頻率代表什麼？能否反映社會資源的實際使用率？',
  subtitle: '現場應用篇 / 使用熱度 × 場域分布 × 成效追蹤',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '現場應用篇', to: '/docs#field' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- 導言 -->
      <section class="lead">
        <h2 class="sr-only">導言</h2>
        <p>
          在社會福利的實務中，<strong>核發≠使用</strong>。社會局雖能統計發出多少補助或憑證，但往往不知道這些資源最後是否真正被使用。
        </p>
        <ul class="bullets">
          <li>有人領到補助資格卻從未使用；</li>
          <li>有人符合資格卻不知道可領；</li>
          <li>也有人在多個單位重複申領但未被追蹤到。</li>
        </ul>
        <p>因此，我們需要新的觀察指標，而「驗證頻率」正是其中之一。</p>
      </section>

      <hr class="div" />

      <!-- 定義 -->
      <section>
        <h2 id="s-def">一、什麼是「驗證頻率」？</h2>
        <p>
          在數位憑證的系統中，每次民眾出示憑證、被驗證一次，就會留下紀錄。這個紀錄不包含個資內容，但會標示出：
        </p>

        <div class="def-table-wrap">
          <table class="def-table">
            <thead>
              <tr><th scope="col">欄位</th><th scope="col">說明</th></tr>
            </thead>
            <tbody>
              <tr><th scope="row">驗證時間</th><td>何時被使用</td></tr>
              <tr><th scope="row">驗證場域</th><td>哪一類單位（例如醫療、慈善、長照）</td></tr>
              <tr><th scope="row">驗證目的</th><td>就醫、領物資、身分查核、報名活動…</td></tr>
              <tr><th scope="row">驗證結果</th><td>是否通過（資格是否有效）</td></tr>
            </tbody>
          </table>
        </div>

        <!-- 小型視覺化：純 CSS 的示意長條 -->
        <figure class="mini-chart" aria-describedby="mini-chart-desc">
          <figcaption>（示意）近 7 日各場域驗證次數</figcaption>
          <ul class="bars">
            <li>
              <span class="label">醫療</span>
              <span class="bar" style="--w: 82%"><i aria-hidden="true"></i><b>82</b></span>
            </li>
            <li>
              <span class="label">慈善</span>
              <span class="bar" style="--w: 55%"><i aria-hidden="true"></i><b>55</b></span>
            </li>
            <li>
              <span class="label">長照</span>
              <span class="bar" style="--w: 64%"><i aria-hidden="true"></i><b>64</b></span>
            </li>
            <li>
              <span class="label">里辦</span>
              <span class="bar" style="--w: 31%"><i aria-hidden="true"></i><b>31</b></span>
            </li>
          </ul>
          <p id="mini-chart-desc" class="note">僅為版面示意，實務請改接真實統計。</p>
        </figure>
      </section>

      <hr class="div" />

      <!-- 觀察面向 -->
      <section>
        <h2 id="s-insight">二、從驗證頻率看見資源使用的真實樣貌</h2>
        <div class="kpi-grid">
          <div class="kpi">
            <span class="kpi-tag">使用熱度</span>
            <p>若某區的身障卡或低收入戶卡驗證次數偏低，可能代表民眾對服務不熟悉，或可用場域不足。反之則代表服務網絡運作良好。</p>
          </div>
          <div class="kpi">
            <span class="kpi-tag">使用時間</span>
            <p>透過時間分布，可發現民眾集中在何時使用（例如月底、颱風後、特定活動期間），作為補助與人力調度依據。</p>
          </div>
          <div class="kpi">
            <span class="kpi-tag">使用地點</span>
            <p>紀錄揭示民眾在哪些場域出現（醫療、里辦、長照、慈善），協助規劃合作優先順序。</p>
          </div>
        </div>
      </section>

      <hr class="div" />

      <!-- 作為社會指標 -->
      <section>
        <h2 id="s-soc">三、從「驗證紀錄」變成「社會指標」</h2>
        <p>當這些匿名化的驗證紀錄被累積起來，它其實就是一種新的社會觀測數據。透過統計分析，我們可以回答：</p>
        <ul class="tick">
          <li>哪些身份別的服務被使用得最頻繁？</li>
          <li>哪些區域的憑證使用率最低？</li>
          <li>哪些時間點需求最高、資源最吃緊？</li>
          <li>哪些合作單位最活躍？</li>
        </ul>
        <p>這些資料能幫助政府調整政策、分配預算，也能協助非營利組織更精準地部署人力與資源。</p>
      </section>

      <hr class="div" />

      <!-- 延伸應用 -->
      <section>
        <h2 id="s-apply">四、延伸應用：從「數據」到「服務改善」</h2>
        <ul class="bullets">
          <li><strong>行政面：</strong>以趨勢追蹤政策成效（例如新補助上線後使用率是否提升）。</li>
          <li><strong>社區面：</strong>辨識「服務空白區」，主動接觸低使用率族群。</li>
          <li><strong>民間合作面：</strong>與慈善機構共享匿名化趨勢數據，共同規劃行動專案。</li>
          <li><strong>評估面：</strong>建立「社福資源使用率」的客觀指標，支援政策審計與公開報告。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 結語 -->
      <section class="callout">
        <h2 id="s-end">五、小結：從一次掃描，連結起整個服務循環</h2>
        <p>
          數位憑證的驗證紀錄，不只是「技術日誌」，而是<strong>公共服務的體溫計</strong>。它讓政府第一次能用量化方式，看見政策在民間是否真的產生作用。
        </p>
        <p>
          最終目標不是讓民眾被追蹤，而是讓社會服務<strong>更能被看見、被理解、被調整</strong>。每一次的掃描，其實都是一次溫度的回報——告訴我們，這張憑證，正在真正地被使用。
        </p>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
/* 色系（暖中性） */
.post {
  --c-ink: #2b2b2b;
  --c-muted: #5a4e47;
  --c-primary: #c96c3b;
  --c-accent: #e7b17d;
  --c-soft: #fff8f2;
  --c-soft-2: #fff2e6;
  --c-line: #ead8c8;
  color: var(--c-ink);
  line-height: 1.8;
}

/* 無障礙隱藏標題 */
.sr-only {
  position: absolute !important;
  width: 1px; height: 1px;
  padding: 0; margin: -1px;
  overflow: hidden; clip: rect(0,0,0,0);
  white-space: nowrap; border: 0;
}

/* 導言卡片 */
.lead {
  background: linear-gradient(180deg, #fffdf9, var(--c-soft));
  border: 1px solid #f0e1d8;
  border-radius: 12px;
  padding: .9rem 1rem;
}

/* 區塊標題 */
.post h2 {
  margin: 1.15rem 0 .55rem;
  font-size: 1.12rem;
  color: var(--c-primary);
  display: inline-flex;
  align-items: center;
  gap: .45rem;
}
.post h2::before {
  content: "";
  width: 10px; height: 10px; border-radius: 50%;
  background: radial-gradient(circle at 40% 40%, var(--c-accent), var(--c-primary));
  display: inline-block;
}

/* 文字與列表 */
.post p { margin: .35rem 0 .75rem; }
.bullets { margin: .35rem 0 .9rem 1.25rem; }
.bullets li { margin: .2rem 0; }
.tick { margin: .35rem 0 .9rem 1.25rem; }
.tick li { list-style: none; position: relative; padding-left: 1.25rem; margin: .22rem 0; }
.tick li::before { content: "✔"; position: absolute; left: 0; top: .1rem; color: var(--c-primary); }

/* 分隔線 */
.div {
  border: 0;
  height: 1px;
  background: linear-gradient(90deg, #f0e6df, var(--c-line) 40%, #f0e6df);
  margin: 1rem 0 1rem;
}

/* 定義表 */
.def-table-wrap { overflow-x: auto; border-radius: 10px; border: 1px solid #efe6de; background: #fff; }
.def-table { width: 100%; border-collapse: collapse; min-width: 480px; }
.def-table thead th {
  text-align: left; font-weight: 700; font-size: .92rem; color: #835b46;
  background: #fff7f0; border-bottom: 1px solid #ead8c8; padding: .55rem .7rem;
}
.def-table tbody th { text-align: left; white-space: nowrap; color: #5a4e47; font-weight: 600; }
.def-table tbody th, .def-table tbody td { padding: .55rem .7rem; border-bottom: 1px solid #f2e7dd; }
.def-table tbody tr:last-child th, .def-table tbody tr:last-child td { border-bottom: 0; }

/* CSS 迷你長條圖（純示意） */
.mini-chart { margin: .7rem 0 .2rem; }
.mini-chart figcaption { font-weight: 600; color: #835b46; margin-bottom: .3rem; }
.mini-chart .bars { list-style: none; margin: 0; padding: 0; display: grid; gap: .45rem; }
.mini-chart .bars li { display: grid; grid-template-columns: 84px 1fr; align-items: center; gap: .6rem; }
.mini-chart .label { color: #5a4e47; font-size: .92rem; }
.mini-chart .bar {
  --h: 10px;
  position: relative; display: inline-flex; align-items: center; gap: .4rem;
  height: var(--h); width: 100%;
}
.mini-chart .bar i {
  position: relative; display: block; height: 100%; width: var(--w); border-radius: 999px;
  background: linear-gradient(90deg, #ffd9bd, #e9a773 55%, #c96c3b);
  box-shadow: 0 1px 6px rgba(201,108,59,.25);
  transition: width .6s cubic-bezier(.22,.61,.36,1);
}
.mini-chart .bar b { font-size: .82rem; color: #82543a; }

/* KPI 卡片 */
.kpi-grid {
  display: grid; grid-template-columns: repeat(auto-fit, minmax(240px,1fr));
  gap: .8rem; margin-top: .3rem;
}
.kpi {
  background: #fff; border: 1px solid #e8e0d9; border-radius: 12px; padding: .75rem .9rem;
  box-shadow: 0 2px 6px rgba(0,0,0,.04);
  transition: transform .2s ease, box-shadow .2s ease, border-color .2s ease;
}
.kpi:hover { transform: translateY(-2px); border-color: #d27b4b33; box-shadow: 0 8px 18px rgba(210,123,75,.14); }
.kpi-tag {
  display: inline-block; font-size: .78rem; font-weight: 700; letter-spacing: .3px;
  color: #8b6a56; background: #fff1e5; border: 1px solid #f0dfd3; border-radius: 999px; padding: .18rem .5rem; margin-bottom: .35rem;
}

/* 提示塊 */
.callout {
  border-left: 4px solid var(--c-primary);
  background: linear-gradient(180deg, #fffdf9, var(--c-soft-2));
  padding: .75rem .9rem; border-radius: 10px;
}

/* 註解 */
.note { color: #7a6c63; font-size: .85rem; margin-top: .25rem; }

/* RWD */
@media (max-width: 768px) {
  .post h2 { font-size: 1.06rem; }
  .mini-chart .bars li { grid-template-columns: 72px 1fr; }
}
</style>
