<!-- components/doc/articles/UserWhyCredentials.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '為什麼我必須使用數位憑證？我不能直接拿健保卡、身分證嗎？',
  subtitle: '使用者觀點篇 / 從身份到資格：少給、精準給',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '使用者觀點篇', to: '/docs#user' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- 一 -->
      <section class="lead">
        <h2 id="s1">一、這個問題非常合理</h2>
        <p>
          多數民眾第一次聽到「數位憑證」時，心裡的第一反應就是：
        </p>
        <blockquote class="quote">
          「我已經有健保卡、身分證了，為什麼還要多一個？」
        </blockquote>
        <p>
          這個疑問很自然，也正是推動數位憑證應用時必須正面回答的問題。若數位憑證只是「身分證的 App 版」，它確實沒有存在的必要。
          它的價值不在於「能證明我是誰」，而在於
          <strong>能在不暴露我是誰的情況下，證明我符合什麼條件。</strong>
        </p>
      </section>

      <hr class="div" />

      <!-- 二 -->
      <section>
        <h2 id="s2">二、傳統證件的邏輯：一證多曝</h2>
        <p>
          身分證與健保卡為「政府／醫療」場景而設計，其核心任務是「確認你的真實身份」。但在許多生活場景，我們需要的其實不是「身份」，而是「資格」。
        </p>
        <ul class="tick">
          <li>領取社福物資：志工只需知道「你有資格」，不需你的姓名與身分證字號。</li>
          <li>申請補助：承辦只需確認「你符合條件」，不需你的完整財稅細節。</li>
          <li>社區活動：主辦只需知道「你是社區居民」，不需你的完整戶籍地址。</li>
        </ul>
        <p>
          傳統證件做不到「只給必要資訊」，於是每次舉證都伴隨一次個資暴露；紙本申請、影印、備份，也成為最大的隱私風險來源之一。
        </p>
      </section>

      <hr class="div" />

      <!-- 三 -->
      <section>
        <h2 id="s3">三、數位憑證的邏輯：少給、精準給</h2>
        <p>
          數位憑證（Verifiable Credential, VC）與傳統證件最大的不同在於：它不是「身份證明」，而是「條件證明」。
        </p>
        <div class="table-wrap">
          <table class="cmp">
            <thead>
              <tr>
                <th>場景</th>
                <th>傳統方式</th>
                <th>數位憑證方式</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>申請補助</td>
                <td>提供身分證、戶籍謄本、財稅資料</td>
                <td>出示「符合低收入戶資格」的 VC</td>
              </tr>
              <tr>
                <td>領取物資</td>
                <td>填姓名＋身分證號</td>
                <td>出示「社福身份卡」QR Code</td>
              </tr>
              <tr>
                <td>醫院掛號補助</td>
                <td>多張紙本證明逐一核驗</td>
                <td>系統驗證「具身障補助資格」</td>
              </tr>
              <tr>
                <td>校園優惠</td>
                <td>提交學生證影本</td>
                <td>出示「在學學生」VC</td>
              </tr>
            </tbody>
          </table>
        </div>
        <p>在這個模型中，你出示的不是「你是誰」，而是「你有什麼資格」。安全、隱私與效率因此取得平衡。</p>
      </section>

      <hr class="div" />

      <!-- 四 -->
      <section>
        <h2 id="s4">四、真正的轉變：從「被驗」到「主動授權」</h2>
        <p>
          傳統流程是各機關「查你的資料」。數位憑證翻轉了邏輯：
        </p>
        <ol class="enum">
          <li>你的資料先被政府簽章，變成你手機裡的憑證。</li>
          <li>需要申請服務時，由你<strong>主動授權</strong>驗證方查看特定內容。</li>
          <li>對方不需登入任何資料庫，就能知道結果真實且有效。</li>
        </ol>
        <blockquote class="quote">
          在紙本時代，我們交出文件。<br />
          在數位時代，我們授予驗證。
        </blockquote>
        <p>這就是「資料自主權」：資料的擁有者是你，而不是政府或平台。</p>
      </section>

      <hr class="div" />

      <!-- 五 -->
      <section>
        <h2 id="s5">五、從民眾的角度來看：到底幫助在哪？</h2>
        <ul class="tick">
          <li><strong>免重複提交：</strong>社會局已核過的資格，一次發憑證、各場域可驗。</li>
          <li><strong>降低外洩風險：</strong>只揭露必要欄位（如「符合低收資格」），不洩漏財稅細節。</li>
          <li><strong>節省行政時間：</strong>免到公所開紙本、免重複影印與蓋章。</li>
          <li><strong>更快被協助：</strong>出示 QR Code，醫院／慈善機構／社區點能立刻知道如何提供協助。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 六 -->
      <section>
        <h2 id="s6">六、延伸意義：讓「信任」從紙本走向流動</h2>
        <p>
          健保卡、身分證是靜態的「身份載具」；數位憑證是動態的「信任載具」。它能代表經政府簽章、可被驗證的事實，例如：
        </p>
        <ul class="dot">
          <li>你具社福身份</li>
          <li>你擁有特定專業資格／完成訓練</li>
          <li>你屬於某組織的有效成員</li>
        </ul>
        <p>每一項都可是一張 VC 卡；當這些卡組合，將形成一張可被驗證的信任網絡。</p>
      </section>

      <hr class="div" />

      <!-- 七 -->
      <section>
        <h2 id="s7">七、小結：它不是要取代身分證，而是補足現實缺口</h2>
        <blockquote class="quote">
          健保卡與身分證，解決的是「你是誰」。<br />
          數位憑證，解決的是「你能做什麼」。
        </blockquote>
        <p>
          在社會服務領域，民眾最需要的不是新的卡，而是更容易被信任的方式。數位憑證讓「信任」首次成為可被驗證、可被攜帶、也可被保護的東西。
        </p>
        <p class="ending">
          所以答案不是「非用不可」，而是：當社會需要更高效率、更少資料曝光、更高包容性時，<strong>它就是更好的方法。</strong>
        </p>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post{
  --c-ink:#2b2b2b;
  --c-muted:#6f675f;
  --c-primary:#b35f37;  /* 暖棕紅，與米白背景協調 */
  --c-accent:#e4b17c;
  --c-soft:#fff8f2;
  --c-surface:#fff;
  --c-line:#ead8c8;
  color:var(--c-ink);
  line-height:1.8;
}

/* 標題與導言 */
.post h2{
  margin:1.12rem 0 .55rem;
  font-size:1.12rem;color:var(--c-primary);
  display:inline-flex;align-items:center;gap:.45rem
}
.post h2::before{
  content:"";width:10px;height:10px;border-radius:50%;
  background:radial-gradient(circle at 40% 40%,var(--c-accent),var(--c-primary));
  display:inline-block
}
.lead{
  background:linear-gradient(180deg,#fffdf9,var(--c-soft));
  border:1px solid #f0e1d8;border-radius:12px;
  padding:.9rem 1rem
}

/* 一般文字與列表 */
.post p{margin:.35rem 0 .75rem}
.enum{margin:.35rem 0 .9rem 1.25rem}
.enum li{margin:.28rem 0}
.tick{margin:.35rem 0 .9rem 1.25rem}
.tick li{list-style:none;position:relative;padding-left:1.25rem;margin:.22rem 0}
.tick li::before{content:"✔";position:absolute;left:0;top:.1rem;color:var(--c-primary)}
.dot{margin:.35rem 0 .9rem 1.25rem}
.dot li{list-style:disc;margin:.28rem 0}

/* 引用與分隔 */
.quote{
  background:#fff;border:1px solid #e8e0d9;border-radius:12px;
  padding:.85rem 1rem;color:#583d30;box-shadow:0 2px 6px rgba(0,0,0,.04);margin:.45rem 0
}
.div{
  border:0;height:1px;
  background:linear-gradient(90deg,#f0e6df,var(--c-line) 40%,#f0e6df);
  margin:1rem 0 1rem
}

/* 表格 */
.table-wrap{overflow-x:auto;border:1px solid #efe6de;border-radius:12px;background:#fff;margin-top:.35rem}
.cmp{width:100%;min-width:640px;border-collapse:collapse}
.cmp thead th{
  text-align:left;font-weight:700;font-size:.92rem;color:#835b46;
  background:#fff7f0;border-bottom:1px solid var(--c-line);padding:.55rem .7rem
}
.cmp tbody td{padding:.55rem .7rem;border-bottom:1px solid #f2e7dd;vertical-align:top}

/* 結語 */
.ending{color:#5d4a40;font-weight:600}

/* RWD */
@media (max-width:768px){
  .post h2{font-size:1.06rem}
}
</style>
