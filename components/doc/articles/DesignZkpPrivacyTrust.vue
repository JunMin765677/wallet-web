<!-- components/doc/articles/DesignZkpPrivacyTrust.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '零知識證明是關於隱私還是信任？誰需要、誰其實不需要？',
  subtitle: '設計理念篇 / 最小揭露 × 可驗真偽 × 信任分工',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '設計理念篇', to: '/docs#philo' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- 一、ZKP 在解什麼題 -->
      <section class="lead">
        <h2 id="s1">一、零知識證明到底在解決什麼問題？</h2>
        <p>
          「零知識證明（Zero-Knowledge Proof, ZKP）」能讓你在<strong>不透露內容</strong>的情況下，證明某件事為真。
          也就是：<em>證明你有資格，而不是證明你是誰</em>。
        </p>
        <ul class="bullets">
          <li>證明「我已滿 18 歲」，但不顯示生日。</li>
          <li>證明「我有補助資格」，但不揭露家庭收入與成員。</li>
          <li>證明「我持有有效身分」，但不提供身分證號。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 二、隱私與信任是同一枚硬幣 -->
      <section>
        <h2 id="s2">二、隱私與信任，其實是同一件事的兩面</h2>
        <p>
          ZKP 常被視為「保護隱私」的工具，但它同時<strong>強化信任</strong>：當「我不用暴露資料也能被你信任」，互動才真正前進。
        </p>
        <div class="table-wrap">
          <table class="cmp">
            <thead>
              <tr><th scope="col">傳統方式</th><th scope="col">零知識證明方式</th></tr>
            </thead>
            <tbody>
              <tr><td>我把資料攤開，你來相信我。</td><td>我只給足夠證據，你自己驗證。</td></tr>
              <tr><td>信任建立在揭露之上。</td><td>信任建立在驗證之上。</td></tr>
              <tr><td>為效率犧牲隱私。</td><td>在效率中保有隱私。</td></tr>
            </tbody>
          </table>
        </div>
        <p>因此，ZKP 的價值不是把資料「藏起來」，而是讓資料<strong>可驗真偽且不可濫用</strong>——把「隱私」變成「被信任的沈默」。</p>
      </section>

      <hr class="div" />

      <!-- 三、誰需要 ZKP -->
      <section>
        <h2 id="s3">三、誰需要零知識證明？</h2>
        <p>是否需要，取決於「<strong>信任的代價</strong>」有多高。</p>
        <div class="grid3">
          <article class="card">
            <h3>政府與公共服務（最需要）</h3>
            <ul class="tick">
              <li>同時握有權力與個資，錯用影響深遠。</li>
              <li>例：不揭露收入細節也能證明「低收身分」。</li>
              <li>例：醫院驗證補助資格，但不接觸明細。</li>
            </ul>
          </article>
          <article class="card">
            <h3>企業與商業（有條件需要）</h3>
            <ul class="tick">
              <li>金融、合規（GDPR/個資法）場景尤為適合。</li>
              <li>例：驗證年齡/會員狀態，不存取原始個資。</li>
            </ul>
          </article>
          <article class="card">
            <h3>一般用戶（間接受益）</h3>
            <ul class="tick">
              <li>系統內建 ZKP → 自然擁有更高隱私保護。</li>
              <li>無須逐案判斷「要不要多給資料」。</li>
            </ul>
          </article>
        </div>
      </section>

      <hr class="div" />

      <!-- 四、誰其實不需要 -->
      <section>
        <h2 id="s4">四、誰其實「不需要」？</h2>
        <p>若技術門檻與運算成本遠高於效益，就不該導入 ZKP：</p>
        <ul class="bullets">
          <li>餐廳會員卡、展覽入場券、一次性折扣 QR code。</li>
          <li>隱私要求低、信任邊界清晰、風險有限。</li>
        </ul>
        <p class="note">不是所有「能用密碼學的地方」都該用密碼學。</p>
      </section>

      <hr class="div" />

      <!-- 五、信任分工 -->
      <section>
        <h2 id="s5">五、零知識證明與「信任分工」</h2>
        <p>ZKP 在多機構系統中的價值是把信任<span class="nowrap">「分工」</span>：</p>
        <ol class="flow">
          <li><span>發證單位簽章</span><small>（不公開明細）</small></li>
          <li><span>驗證單位驗簽</span><small>（不接手風險）</small></li>
          <li><span>民眾主控揭露</span><small>（何時、揭露哪些欄位）</small></li>
        </ol>
        <p>社會信任由「集中式」轉為「分散式」：各司其職、互信可驗、責任可追。</p>
      </section>

      <hr class="div" />

      <!-- 六、小結 -->
      <section class="callout">
        <h2 id="s6">六、小結：ZKP 不是「躲起來」，而是「重新定義信任」</h2>
        <p>
          ZKP 讓我們從「相信別人給的資料」，轉為「相信證明本身」。它不是單純的隱私工具，而是一種新的信任協議。
        </p>
        <blockquote class="quote">
          需要被信任、又不該被看透的人——最值得 ZKP 保護。<br>
          在社福應用裡，這正是它存在的意義。
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

/* 文本與列表 */
.post p{margin:.35rem 0 .75rem}
.bullets{margin:.35rem 0 .9rem 1.25rem}
.bullets li{margin:.22rem 0}
.note{color:#7a6c63;font-size:.88rem}

/* 分隔線 */
.div{
  border:0;height:1px;
  background:linear-gradient(90deg,#f0e6df,var(--c-line) 40%,#f0e6df);
  margin:1rem 0 1rem;
}

/* 對照表 */
.table-wrap{overflow-x:auto;border:1px solid #efe6de;border-radius:12px;background:#fff}
.cmp{width:100%;min-width:560px;border-collapse:collapse}
.cmp thead th{
  text-align:left;font-weight:700;font-size:.92rem;color:#835b46;
  background:#fff7f0;border-bottom:1px solid var(--c-line);padding:.55rem .7rem
}
.cmp tbody td{padding:.55rem .7rem;border-bottom:1px solid #f2e7dd}
.cmp tbody tr:last-child td{border-bottom:0}

/* 三欄卡 */
.grid3{
  display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));
  gap:.85rem;margin-top:.35rem
}
.card{
  background:var(--c-surface);border:1px solid #e8e0d9;border-radius:12px;
  padding:.8rem .95rem;box-shadow:0 2px 6px rgba(0,0,0,.04);
  transition:transform .2s ease,box-shadow .2s ease,border-color .2s ease
}
.card:hover{transform:translateY(-2px);border-color:#d27b4b33;box-shadow:0 8px 18px rgba(210,123,75,.14)}
.card h3{margin:0 0 .35rem;color:#b35f37;font-size:1rem}

/* 勾選清單 */
.tick{margin:.35rem 0 .9rem 1.25rem}
.tick li{list-style:none;position:relative;padding-left:1.25rem;margin:.22rem 0}
.tick li::before{content:"✔";position:absolute;left:0;top:.1rem;color:var(--c-primary)}

/* 流程帶（信任分工） */
.flow{
  counter-reset:step;display:flex;flex-wrap:wrap;gap:.6rem;margin:.4rem 0 .6rem;padding:0;list-style:none
}
.flow li{
  counter-increment:step;
  position:relative;background:#fff;border:1px solid #e8e0d9;border-radius:999px;
  padding:.4rem .8rem .4rem 2rem;box-shadow:0 2px 6px rgba(0,0,0,.04)
}
.flow li::before{
  content:counter(step);
  position:absolute;left:.55rem;top:50%;transform:translateY(-50%);
  width:1.2rem;height:1.2rem;border-radius:50%;display:inline-flex;align-items:center;justify-content:center;
  background:#fff1e5;border:1px solid #f0dfd3;color:#8b6a56;font-weight:700;font-size:.82rem
}
.flow small{color:#8a7569;margin-left:.35rem}

/* Callout / 引文 */
.callout{
  border-left:4px solid var(--c-primary);
  background:linear-gradient(180deg,#fffdf9,var(--c-soft));
  padding:.75rem .9rem;border-radius:10px
}
.quote{
  background:#fff;border:1px solid #e8e0d9;border-radius:12px;
  padding:.85rem 1rem;color:#583d30;box-shadow:0 2px 6px rgba(0,0,0,.04);margin-top:.4rem
}

/* RWD */
@media (max-width:768px){
  .post h2{font-size:1.06rem}
}
</style>
