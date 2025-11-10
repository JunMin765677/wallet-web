<!-- components/doc/articles/DesignSensitiveButNeeded.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '為什麼社福身份憑證這麼敏感，卻又非做不可？',
  subtitle: '設計理念篇 / 隱私強化 × 可驗證性 × 公共信任',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '設計理念篇', to: '/docs#philo' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- 一、從紙本到數位 -->
      <section class="lead">
        <h2 id="s1">一、從紙本到數位，問題不是「能不能」，而是「怎麼做」</h2>
        <p>
          在社會福利體系裡，<strong>「身份」幾乎等於「權利」</strong>。每一張證明書、核定通知、公文抬頭，
          都代表著一段被系統確認的生活處境：誰需要幫助、能領多少、可以去哪裡申請。
        </p>
        <p>
          因此，「數位化」從來不只是技術升級；它牽涉個資安全、污名風險、資料主權、社會信任——
          一個小小的 QR Code，承載的是社會如何看待「弱勢」的方式。
        </p>
      </section>

      <hr class="div" />

      <!-- 二、為什麼這麼敏感 -->
      <section>
        <h2 id="s2">二、為什麼這麼敏感？</h2>
        <p>社福身份資料是最私密、也最容易被誤用的資料類型之一，包含：</p>
        <ul class="bullets">
          <li>收入與財產狀況</li>
          <li>家庭組成、監護關係</li>
          <li>健康或身心狀態</li>
          <li>申請與核定紀錄</li>
        </ul>
        <p>
          一旦外洩，不只侵犯隱私，更可能造成標籤與歧視。現實中，民眾因身障證明外顯而受異樣眼光的情況並不少見，
          這使「數位化」成為<strong>高風險工程</strong>。
        </p>

        <div class="shield">
          <span class="i" aria-hidden="true">🛡️</span>
          <div>
            <p class="t">設計前提：以最小揭露守住尊嚴</p>
            <p class="d">不是把資料推得更遠，而是讓資料走得更少、卻更可信。</p>
          </div>
        </div>
      </section>

      <hr class="div" />

      <!-- 三、為什麼又非做不可 -->
      <section>
        <h2 id="s3">三、但為什麼又「非做不可」？</h2>
        <p>因為現行紙本制度已達臨界點：</p>
        <div class="grid3">
          <article class="card">
            <h3>行政流程過重</h3>
            <p>民眾重複申請、重複繳交；跨局處無法互信，造成「一份資料跑五個地方」。</p>
          </article>
          <article class="card">
            <h3>資料更新不即時</h3>
            <p>身份變更難以回寫，延遲、錯發屢見不鮮。</p>
          </article>
          <article class="card">
            <h3>紙本難偽難整合</h3>
            <p>格式各異、驗真仰賴人工；防偽弱、無撤銷機制。</p>
          </article>
        </div>
        <p>問題疊加，第一線社工、醫院社工、慈善機構都疲於奔命。「做不做」不再是選擇，重點是<strong>怎麼做得安全、可控、被信任</strong>。</p>
      </section>

      <hr class="div" />

      <!-- 四、結構性轉變：紙本 vs VC -->
      <section>
        <h2 id="s4">四、數位憑證帶來的結構性轉變</h2>
        <p>數位憑證不是讓資料更容易傳遞，而是讓資料<strong>更能被正確驗證</strong>：</p>
        <div class="table-wrap">
          <table class="cmp">
            <thead>
              <tr><th scope="col">傳統紙本</th><th scope="col">數位憑證（VC）</th></tr>
            </thead>
            <tbody>
              <tr><td>必須「看見內容」才能信任</td><td>不看內容也能驗簽（加密簽章）</td></tr>
              <tr><td>以公文/印章作為信任來源</td><td>以憑證簽章+發行者身分作為信任來源</td></tr>
              <tr><td>易偽造、難更新、難撤銷</td><td>難偽造、可即時撤銷與更新</td></tr>
              <tr><td>各單位各自留副本、難控管</td><td>資料駐留民眾端，由本人主控</td></tr>
            </tbody>
          </table>
        </div>
        <p>真正的「隱私強化」在於：<strong>資料少流動，信任卻能流通</strong>。</p>
      </section>

      <hr class="div" />

      <!-- 五、核心信念 -->
      <section class="callout">
        <h2 id="s5">五、核心信念：資料不應該「被分享」，而應該「被驗證」</h2>
        <p>
          設計哲學是：讓真實能被信任，但隱私不被暴露。過去用資料交換換效率；
          未來以加密驗證換取信任與可追溯性。
        </p>
        <ul class="tick">
          <li>以<strong>選擇性揭露</strong>替代一次看光。</li>
          <li>以<strong>撤銷/有效期</strong>替代失控的影本。</li>
          <li>以<strong>可審計但去識別</strong>替代人工對帳。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 六、小結 -->
      <section>
        <h2 id="s6">六、小結：敏感不是阻力，而是設計的起點</h2>
        <p>
          社福數位憑證必須同時「保護脆弱的人」與「讓社會能運作」。它敏感，因為關乎尊嚴；它必要，因為關乎效率與信任。
        </p>
        <blockquote class="quote">
          在數位社會裡，我們如何確保「被幫助的人」仍然保有主體性？<br />
          答案是：<strong>最小揭露、可驗可撤、由本人主控</strong>。
        </blockquote>
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

/* 區塊標題 */
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
.bullets li{margin:.2rem 0}

/* 視覺分隔線 */
.div{
  border:0;height:1px;
  background:linear-gradient(90deg,#f0e6df,var(--c-line) 40%,#f0e6df);
  margin:1rem 0 1rem
}

/* 小提示（盾牌） */
.shield{
  display:flex;gap:.6rem;align-items:flex-start;
  background:#fff;border:1px solid #e8e0d9;border-radius:12px;
  padding:.7rem .85rem;box-shadow:0 2px 6px rgba(0,0,0,.04)
}
.shield .i{font-size:1.1rem}
.shield .t{margin:0;font-weight:700;color:#7a523f}
.shield .d{margin:.1rem 0 0;color:#5a4e47}

/* 三欄卡片 */
.grid3{
  display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
  gap:.8rem;margin-top:.4rem
}
.card{
  background:var(--c-surface);border:1px solid #e8e0d9;border-radius:12px;
  padding:.75rem .9rem;box-shadow:0 2px 6px rgba(0,0,0,.04);
  transition:transform .2s ease,box-shadow .2s ease,border-color .2s ease
}
.card:hover{transform:translateY(-2px);border-color:#d27b4b33;box-shadow:0 8px 18px rgba(210,123,75,.14)}
.card h3{margin:0 0 .35rem;color:#b35f37;font-size:1rem}

/* 對照表 */
.table-wrap{overflow-x:auto;border:1px solid #efe6de;border-radius:12px;background:#fff;margin-top:.4rem}
.cmp{width:100%;min-width:520px;border-collapse:collapse}
.cmp thead th{
  text-align:left;font-weight:700;font-size:.92rem;color:#835b46;
  background:#fff7f0;border-bottom:1px solid var(--c-line);padding:.55rem .7rem
}
.cmp tbody td{padding:.55rem .7rem;border-bottom:1px solid #f2e7dd}
.cmp tbody tr:last-child td{border-bottom:0}

/* Callout */
.callout{
  border-left:4px solid var(--c-primary);
  background:linear-gradient(180deg,#fffdf9,var(--c-soft));
  padding:.75rem .9rem;border-radius:10px
}
.tick{margin:.35rem 0 .1rem 1.25rem}
.tick li{list-style:none;position:relative;padding-left:1.25rem;margin:.22rem 0}
.tick li::before{
  content:"✔";position:absolute;left:0;top:.1rem;color:var(--c-primary)
}

/* 引文 */
.quote{
  background:#fff;border:1px solid #e8e0d9;border-radius:12px;
  padding:.8rem .95rem;color:#583d30;box-shadow:0 2px 6px rgba(0,0,0,.04)
}

/* RWD */
@media (max-width:768px){
  .post h2{font-size:1.06rem}
}
</style>
