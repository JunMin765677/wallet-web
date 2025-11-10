<!-- components/doc/articles/DesignSdJwtAccessibility.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '如果現行的身障證明揭露太多個資，我們該怎麼用「選擇性揭露」來修正？',
  subtitle: '設計理念篇 / SD-JWT × 部分揭露 × 使用者主控',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '設計理念篇', to: '/docs#philo' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- 一、問題的現實 -->
      <section class="lead">
        <h2 id="s1">一、問題的現實：紙本證明其實很「透明」</h2>
        <p>在台灣的實務現場，一張身障證明往往包含以下敏感欄位：</p>

        <div class="table-wrap">
          <table class="cmp">
            <thead>
              <tr>
                <th scope="col">欄位</th>
                <th scope="col">敏感度說明</th>
              </tr>
            </thead>
            <tbody>
              <tr><td>姓名、身分證字號、生日、地址</td><td>可直接識別個人</td></tr>
              <tr><td>障礙等級、障礙類別</td><td>高度隱私，易造成標籤與歧視</td></tr>
              <tr><td>醫師診斷、核定日期</td><td>醫療資訊與時效性判斷</td></tr>
            </tbody>
          </table>
        </div>

        <blockquote class="quote">
          「為了證明我有資格接受協助，我必須先被別人完全看透。」<br />
          — 選擇性揭露正要解決的社會問題
        </blockquote>
      </section>

      <hr class="div" />

      <!-- 二、核心精神 -->
      <section>
        <h2 id="s2">二、「選擇性揭露」的核心精神</h2>
        <p>讓持有者<strong>只揭露必要資訊</strong>，驗證方拿到的是「答案」而非「原因」。例如：</p>
        <ul class="tick">
          <li>活動申請：只需「屬於身心障礙者」。</li>
          <li>醫院特別掛號：只需「等級 ≥ 中度」。</li>
          <li>大眾運輸優惠：只需「符合身障票種」。</li>
        </ul>

        <div class="callout">
          <p><strong>要點：</strong>以「結果」替代「明細」，以驗證替代交卷。</p>
        </div>
      </section>

      <hr class="div" />

      <!-- 三、流程轉換 -->
      <section>
        <h2 id="s3">三、從「給資料」轉向「授權驗證」</h2>
        <ol class="flow">
          <li><span>使用者授權</span><small>（挑選此次要揭露的欄位）</small></li>
          <li><span>驗證端驗簽</span><small>（檢查簽章真偽與有效期）</small></li>
          <li><span>回應結果</span><small>（通過/不通過/必要備註）</small></li>
        </ol>
        <p>資料不再在機關間自由流動，透過<strong>加密簽章</strong>完成信任傳遞，資料的主體地位回到使用者。</p>
      </section>

      <hr class="div" />

      <!-- 四、技術如何做到（SD-JWT / Partial Proof） -->
      <section>
        <h2 id="s4">四、技術上怎麼做到？（SD-JWT／部分揭露）</h2>
        <p>選擇性揭露仰賴<strong>結構化簽章</strong>與<strong>部分揭露驗證（Partial Proof）</strong>，簡化如下：</p>
        <div class="grid3">
          <article class="card">
            <h3>1. 發證</h3>
            <p>政府簽發「身障資格 VC / SD-JWT」，包含姓名、等級、類別、有效期限等欄位。</p>
          </article>
          <article class="card">
            <h3>2. 選擇揭露</h3>
            <p>出示時只產生「等級 ≥ 中度」「資格有效」等<strong>必要證明</strong>，隱藏其餘欄位。</p>
          </article>
          <article class="card">
            <h3>3. 驗簽通過</h3>
            <p>驗證端僅看到授權欄位，仍可確認簽章真實且未竄改。</p>
          </article>
        </div>
        <p class="note">這是一種「可驗證但不透明」的信任模式。</p>
      </section>

      <hr class="div" />

      <!-- 五、UX 觀點 -->
      <section>
        <h2 id="s5">五、使用者體驗面：從被檢查者 → 成為主動者</h2>
        <ul class="bullets">
          <li><strong>欄位選擇：</strong>一次性勾選要揭露的欄位組合，可儲存常用組合。</li>
          <li><strong>時效設定：</strong>授權可設一次性 / 限時有效，逾時自動失效。</li>
          <li><strong>可視化提示：</strong>清楚顯示「此次只揭露：等級、有效期」。</li>
        </ul>
        <p>流程不只是安全升級，更是<strong>尊重與主體性</strong>的回復。</p>
      </section>

      <hr class="div" />

      <!-- 六、制度延伸 -->
      <section>
        <h2 id="s6">六、制度上的延伸價值</h2>
        <ul class="tick">
          <li><strong>跨部門更容易：</strong>交換「驗證結果」而非「完整資料」。</li>
          <li><strong>外洩風險更低：</strong>減少複本、避免多點存放。</li>
          <li><strong>信任標準化：</strong>統一簽章與驗證機制，形成公共信任網。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 七、小結 -->
      <section class="wrapup">
        <h2 id="s7">七、小結：從揭露到自控，從身分到尊嚴</h2>
        <p>
          選擇性揭露討論的不是密碼學本身，而是<strong>人</strong>。它讓「被幫助的人」在被看見的同時不失去尊嚴。
          一張數位身障證明，應該是一把鑰匙——<strong>讓信任流通，但讓隱私留在原地</strong>。
        </p>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post{
  --c-ink:#2b2b2b;
  --c-muted:#5a4e47;
  --c-primary:#b35f37;   /* 暖棕紅，與整站米白背景協調 */
  --c-accent:#e4b17c;
  --c-soft:#fff8f2;      /* 柔和填充 */
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

/* 導言區 */
.lead{
  background:linear-gradient(180deg,#fffdf9,var(--c-soft));
  border:1px solid #f0e1d8;border-radius:12px;
  padding:.9rem 1rem;
}

/* 文字與列表 */
.post p{margin:.35rem 0 .75rem}
.bullets{margin:.35rem 0 .9rem 1.25rem}
.bullets li{margin:.22rem 0}
.tick{margin:.35rem 0 .9rem 1.25rem}
.tick li{list-style:none;position:relative;padding-left:1.25rem;margin:.22rem 0}
.tick li::before{content:"✔";position:absolute;left:0;top:.1rem;color:var(--c-primary)}
.note{color:#7a6c63;font-size:.88rem}

/* 分隔線 */
.div{
  border:0;height:1px;
  background:linear-gradient(90deg,#f0e6df,var(--c-line) 40%,#f0e6df);
  margin:1rem 0 1rem;
}

/* 對照表 / 欄位表 */
.table-wrap{overflow-x:auto;border:1px solid #efe6de;border-radius:12px;background:#fff;margin-top:.4rem}
.cmp{width:100%;min-width:560px;border-collapse:collapse}
.cmp thead th{
  text-align:left;font-weight:700;font-size:.92rem;color:#835b46;
  background:#fff7f0;border-bottom:1px solid var(--c-line);padding:.55rem .7rem
}
.cmp tbody td{padding:.55rem .7rem;border-bottom:1px solid #f2e7dd}
.cmp tbody tr:last-child td{border-bottom:0}

/* 卡片網格 */
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

/* 流程帶 */
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
  padding:.75rem .9rem;border-radius:10px;margin-top:.4rem
}
.quote{
  background:#fff;border:1px solid #e8e0d9;border-radius:12px;
  padding:.85rem 1rem;color:#583d30;box-shadow:0 2px 6px rgba(0,0,0,.04);margin-top:.6rem
}

/* RWD */
@media (max-width:768px){
  .post h2{font-size:1.06rem}
}
</style>
