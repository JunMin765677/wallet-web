<!-- components/doc/articles/FieldLowFrequency.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '如果驗證頻率過低，代表這個憑證沒有價值嗎？',
  subtitle: '現場應用篇 / 可被驗證性 × 制度韌性 × 信任外溢',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '現場應用篇', to: '/docs#field' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- 一、被誤解的數字 -->
      <section>
        <h2 id="s1">一、被誤解的數字：使用次數不是唯一指標</h2>
        <blockquote class="quote">
          「憑證被掃得少，代表推動成效差。」— 這個推論在社福脈絡中<strong>並不成立</strong>。
        </blockquote>
        <p>
          低驗證頻率並不代表憑證「沒用」，而可能意味著它讓需要的人更快被確認、讓不需要的人更安心地不被打擾。
          就像醫療保險卡不必天天刷，但它的存在讓整個醫療體系有了可運作的信任基礎。
        </p>
      </section>

      <hr class="div" />

      <!-- 二、可被驗證性 -->
      <section>
        <h2 id="s2">二、「可被驗證」本身就是一種價值</h2>
        <p>
          數位憑證的價值在於當「需要驗證」的時刻出現時，它能即刻生效、無須紙本。這種
          <strong>可被驗證性（verifiability）</strong>意味著：
        </p>

        <ul class="tick">
          <li>身份資訊可以即時被信任。</li>
          <li>不必透過文件、電話、人工查核來佐證。</li>
          <li>在跨單位流程中，能縮短等待與確認時間。</li>
        </ul>

        <!-- 小KPI條，強調價值不是次數 -->
        <div class="kpi-row" role="list">
          <div class="kpi" role="listitem">
            <span class="kpi-label">等待時間</span>
            <span class="kpi-val">↓</span>
          </div>
          <div class="kpi" role="listitem">
            <span class="kpi-label">紙本依賴</span>
            <span class="kpi-val">↓</span>
          </div>
          <div class="kpi" role="listitem">
            <span class="kpi-label">可信度</span>
            <span class="kpi-val up">↑</span>
          </div>
        </div>
      </section>

      <hr class="div" />

      <!-- 三、低頻使用、高價值情境 -->
      <section>
        <h2 id="s3">三、低頻使用、高價值的典型情境</h2>
        <div class="cards">
          <article class="card">
            <h3>災害應變</h3>
            <p>平時少用，災時成為快速辨識的關鍵工具。</p>
          </article>
          <article class="card">
            <h3>身份核對</h3>
            <p>對象不常更動，但需要時必須正確無誤（如低收／身障資格）。</p>
          </article>
          <article class="card">
            <h3>一次性核驗</h3>
            <p>一年只領一次物資，但每次驗證需安全、正確、具公信力。</p>
          </article>
          <article class="card">
            <h3>跨機構協作</h3>
            <p>在不同單位間流通時，減少人工交叉核對的負擔。</p>
          </article>
        </div>
        <p class="note">這些場景「少用但不能沒有」，支撐的是<strong>制度韌性</strong>。</p>
      </section>

      <hr class="div" />

      <!-- 四、信任外溢 -->
      <section>
        <h2 id="s4">四、數據之外的意義：信任的外溢效果</h2>
        <ul class="bullets">
          <li><strong>民眾</strong>開始相信政府資料是可用、可控、可被尊重的。</li>
          <li><strong>善心機構</strong>相信驗證結果值得依賴，不必保存名冊或個資。</li>
          <li><strong>各單位</strong>相信「不看資料本體，也能確定真偽」的流程設計。</li>
        </ul>

        <!-- 流程帶：一次驗證＝一次協作成功 -->
        <ol class="flow">
          <li><span>出示憑證</span></li>
          <li><span>即時驗證</span></li>
          <li><span>完成協作</span></li>
          <li><span>匿名留痕</span></li>
        </ol>
        <p class="note">即使一天只有十次驗證，也代表十次信任交換完成。</p>
      </section>

      <hr class="div" />

      <!-- 五、從高頻到高信任 -->
      <section>
        <h2 id="s5">五、從「高頻運作」到「高信任支撐」</h2>
        <p>推動數位憑證時，若只看「掃描次數」或「使用率」，等於用商業平台的邏輯看待公共服務。真正該問的是：</p>
        <ul class="q-list">
          <li>這個憑證是否在<strong>關鍵時刻</strong>派上用場？</li>
          <li>驗證是否能<strong>被信任</strong>？</li>
          <li>是否成功<strong>降低</strong>行政與舉證負擔？</li>
        </ul>
        <p>只要答案是「是」，即使一年只被驗一次，這張憑證仍然具有<strong>極高公共價值</strong>。</p>
      </section>

      <hr class="div" />

      <!-- 六、小結 -->
      <section class="callout">
        <h2 id="s6">六、小結：數位信任的基礎建設，不以次數為衡量</h2>
        <p>
          數位憑證的意義不在於取代紙本的頻率，而在於當真實需求出現時，能讓信任流程<strong>更短、更安全、更尊重人</strong>。
        </p>
        <p>
          低驗證頻率可能代表系統成熟、民眾不必跑公所、不必重複證明自己。真正的成功，不是掃描次數增加，
          而是有一天，我們幾乎不必掃描，也能被社會自動理解與信任。
        </p>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
/* 暖中性配色，與其他文章互不干擾 */
.post{
  --c-ink:#2b2b2b;
  --c-muted:#5a4e47;
  --c-primary:#c96c3b;
  --c-accent:#e7b17d;
  --c-soft:#fff8f2;
  --c-line:#ead8c8;
  color:var(--c-ink);
  line-height:1.8;
}

/* 標題 */
.post h2{
  margin:1.1rem 0 .55rem;
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

/* 文字與列表 */
.post p{margin:.35rem 0 .75rem}
.bullets{margin:.35rem 0 .9rem 1.25rem}
.bullets li{margin:.2rem 0}
.tick{margin:.35rem 0 .9rem 1.25rem}
.tick li{list-style:none;position:relative;padding-left:1.25rem;margin:.22rem 0}
.tick li::before{content:"✔";position:absolute;left:0;top:.1rem;color:var(--c-primary)}
.q-list{margin:.35rem 0 .9rem 1.25rem}
.q-list li{margin:.28rem 0}

/* 引言與分隔 */
.quote{
  background:linear-gradient(180deg,#fffdf9,var(--c-soft));
  border:1px solid #f0e1d8;border-radius:12px;
  padding:.75rem .9rem;color:#583d30
}
.div{
  border:0;height:1px;
  background:linear-gradient(90deg,#f0e6df,var(--c-line) 40%,#f0e6df);
  margin:1rem 0 1rem
}

/* KPI 小徽章列 */
.kpi-row{display:flex;flex-wrap:wrap;gap:.5rem;margin-top:.5rem}
.kpi{
  display:flex;align-items:center;gap:.45rem;
  border:1px solid #e8e0d9;border-radius:999px;
  background:#fff;padding:.25rem .6rem;box-shadow:0 2px 6px rgba(0,0,0,.04)
}
.kpi-label{font-size:.82rem;color:#8b6a56}
.kpi-val{font-weight:800;color:#9b3b2a}
.kpi-val.up{color:#2a7a55}

/* 情境卡片 */
.cards{
  display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
  gap:.8rem;margin-top:.4rem
}
.card{
  background:#fff;border:1px solid #e8e0d9;border-radius:12px;padding:.75rem .9rem;
  box-shadow:0 2px 6px rgba(0,0,0,.04);
  transition:transform .2s ease,box-shadow .2s ease,border-color .2s ease
}
.card:hover{transform:translateY(-2px);border-color:#d27b4b33;box-shadow:0 8px 18px rgba(210,123,75,.14)}
.card h3{margin:0 0 .35rem;color:#b35f37;font-size:1rem}

/* 流程帶 */
.flow{
  counter-reset:step;display:flex;flex-wrap:wrap;gap:.6rem;margin:.4rem 0 .6rem;padding:0;list-style:none
}
.flow li{
  counter-increment:step;
  position:relative;background:#fff;border:1px solid #e8e0d9;border-radius:999px;
  padding:.35rem .7rem .35rem 2rem; box-shadow:0 2px 6px rgba(0,0,0,.04)
}
.flow li::before{
  content:counter(step);position:absolute;left:.5rem;top:50%;transform:translateY(-50%);
  width:1.2rem;height:1.2rem;border-radius:50%;display:inline-flex;align-items:center;justify-content:center;
  background:#fff1e5;border:1px solid #f0dfd3;color:#8b6a56;font-weight:700;font-size:.82rem
}

/* 強調區 */
.callout{
  border-left:4px solid var(--c-primary);
  background:linear-gradient(180deg,#fffdf9,var(--c-soft));
  padding:.8rem .95rem;border-radius:10px
}
.note{color:#7a6c63;font-size:.88rem}

/* RWD */
@media (max-width:768px){
  .post h2{font-size:1.06rem}
}
</style>
