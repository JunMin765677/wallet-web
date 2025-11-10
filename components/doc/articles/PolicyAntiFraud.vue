<!-- components/doc/articles/PolicyAntiFraud.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '我們該如何防止「偽造社福身份」或「假驗證」？',
  subtitle: '技術與政策篇 / 信任鏈 × 授權清單 × 稽核偵測',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '技術與政策篇', to: '/docs#policy' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- 一、問題本質 -->
      <section class="lead">
        <h2 id="s1">一、問題不是「假卡」，而是「假信任」</h2>
        <p>
          紙本時代的防偽重點在卡面（壓印、水印、雷射標籤）；數位憑證時代，
          真正的風險是<strong>偽造簽發、偽造驗證、錯誤信任</strong>三件事。
        </p>
        <ol class="enum">
          <li><strong>假簽發：</strong>冒用系統權限、偽造發證單位。</li>
          <li><strong>假驗證：</strong>偽造驗證端 App，誘使民眾授權或外洩資料。</li>
          <li><strong>假信任：</strong>驗證端信任未授權的發證來源或信任域。</li>
        </ol>
        <div class="callout">
          <p><strong>重點：</strong>防偽不是防「卡」，而是守住整條<strong>信任鏈</strong>不被繞過。</p>
        </div>
      </section>

      <hr class="div" />

      <!-- 二、簽章機制 -->
      <section>
        <h2 id="s2">二、防偽的第一層：簽章機制（誰簽發）</h2>
        <p>
          每張 VC 由具名的發證者（<strong>Issuer DID</strong>）簽章。可靠與否不在卡面，而在<strong>私鑰簽章與可查驗的公鑰</strong>。
        </p>
        <ul class="tick">
          <li><strong>唯一發證者身份（Issuer DID）：</strong>公鑰登錄於<strong>信任名錄（Trust Registry）</strong>，驗證端僅信任名錄內簽章。</li>
          <li><strong>撤銷與狀態查核：</strong>金鑰外洩可撤銷；憑證有效性可在不揭露個資下被查驗。</li>
          <li><strong>定期輪替金鑰：</strong>公部門建議年度輪替並落實 HSM 與審計。</li>
        </ul>
        <blockquote class="quote">可信不在誰持有，而在<strong>誰簽的、誰保證的</strong>。</blockquote>
      </section>

      <hr class="div" />

      <!-- 三、驗證端授權 -->
      <section>
        <h2 id="s3">三、防偽的第二層：驗證端授權（誰在驗）</h2>
        <p>
          假驗證比假卡更危險。需建立<strong>授權驗證清單（Authorized Verifiers）</strong>與驗證端身份（Verifier DID）。
        </p>
        <ul class="tick">
          <li>每個驗證 App 具唯一 Verifier DID，註冊於中央清單。</li>
          <li>App 啟動時向信任清單伺服器確認授權狀態；未授權或遭撤銷即被拒絕互動。</li>
          <li>民眾端可見「誰在向你請求驗證」，形成清楚的授權邊界。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 四、互認信任鏈 -->
      <section>
        <h2 id="s4">四、防偽的第三層：互認信任鏈（信誰的簽章）</h2>
        <p>
          憑證與驗證端皆真實，但若不在同一信任範圍仍可能「錯信任」。需採<strong>信任聯盟（Trust Federation）</strong>。
        </p>
        <div class="grid2">
          <article class="card">
            <h3>根信任（Root of Trust）</h3>
            <p>由中央/主管機關維護全域信任根目錄，管理各領域子信任圈。</p>
          </article>
          <article class="card">
            <h3>子信任圈（Sub-Trust Domain）</h3>
            <p>醫療、教育、社福、公益各自成圈；驗證時比對憑證所屬領域是否被允許。</p>
          </article>
        </div>
        <p class="note">醫療憑證→醫療圈驗證；社福憑證→社福圈驗證；跨圈需中央認可。</p>
      </section>

      <hr class="div" />

      <!-- 五、行為稽核與異常偵測 -->
      <section>
        <h2 id="s5">五、防偽的第四層：行為稽核與異常偵測</h2>
        <ul class="tick">
          <li><strong>事件留痕：</strong>簽發、撤銷、驗證皆產生匿名事件（時間、動作、結果）。</li>
          <li><strong>異常警示：</strong>短時間大量簽發/驗證自動觸發節流或暫停金鑰。</li>
          <li><strong>行為特徵：</strong>從簽章節奏、網域、API 使用樣態辨識自動化濫用。</li>
        </ul>
        <div class="callout">
          <p><strong>真正的防詐：</strong>不只加鎖，更要能及時發現<strong>誰在嘗試開鎖</strong>。</p>
        </div>
      </section>

      <hr class="div" />

      <!-- 六、使用者教育與透明介面 -->
      <section>
        <h2 id="s6">六、防偽的第五層：使用者教育與透明介面</h2>
        <ul class="tick">
          <li><strong>清楚顯示驗證對象：</strong>出示前明示「你正授權給：○○單位」。</li>
          <li><strong>風險提示：</strong>不在授權清單 → 顯示紅色警示與阻擋互動。</li>
          <li><strong>掃碼即知道：</strong>任何驗證畫面皆可一眼看到是否經政府認證。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 七、總結表 -->
      <section>
        <h2 id="s7">七、小結：防偽的本質是「透明可查證」</h2>
        <div class="table-wrap">
          <table class="cmp">
            <thead>
              <tr>
                <th>層級</th>
                <th>核心機制</th>
                <th>保護對象</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>1. 簽章層</td>
                <td>Issuer DID、金鑰管理、撤銷名錄</td>
                <td>憑證真偽</td>
              </tr>
              <tr>
                <td>2. 驗證層</td>
                <td>授權驗證清單、Verifier DID</td>
                <td>使用者資料</td>
              </tr>
              <tr>
                <td>3. 信任層</td>
                <td>根信任＋子信任圈的聯盟</td>
                <td>機構互信</td>
              </tr>
              <tr>
                <td>4. 稽核層</td>
                <td>事件留痕、異常偵測、智能封鎖</td>
                <td>系統安全</td>
              </tr>
              <tr>
                <td>5. 使用者層</td>
                <td>透明授權提示、風險警示</td>
                <td>公眾信任</td>
              </tr>
            </tbody>
          </table>
        </div>
        <blockquote class="quote">
          目標不是「讓人造不出假卡」，而是「讓假卡<strong>沒有市場</strong>」：<br />
          三方共享同一條可查證的信任鏈，偽造自然失效。
        </blockquote>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post{
  --c-ink:#2b2b2b;
  --c-muted:#5a4e47;
  --c-primary:#b35f37;  /* 暖棕紅，與米白背景協調 */
  --c-accent:#e4b17c;
  --c-soft:#fff8f2;
  --c-surface:#fff;
  --c-line:#ead8c8;
  color:var(--c-ink);
  line-height:1.8;
}

/* 標題、導言 */
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
.lead{
  background:linear-gradient(180deg,#fffdf9,var(--c-soft));
  border:1px solid #f0e1d8;border-radius:12px;
  padding:.9rem 1rem;
}

/* 文字與列表 */
.post p{margin:.35rem 0 .75rem}
.enum{margin:.35rem 0 .9rem 1.25rem}
.enum li{margin:.28rem 0}
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

/* 表格 */
.table-wrap{overflow-x:auto;border:1px solid #efe6de;border-radius:12px;background:#fff;margin-top:.35rem}
.cmp{width:100%;min-width:640px;border-collapse:collapse}
.cmp thead th{
  text-align:left;font-weight:700;font-size:.92rem;color:#835b46;
  background:#fff7f0;border-bottom:1px solid var(--c-line);padding:.55rem .7rem
}
.cmp tbody td{padding:.55rem .7rem;border-bottom:1px solid #f2e7dd;vertical-align:top}

/* 卡片與網格 */
.grid2{display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:.85rem;margin-top:.35rem}
.card{
  background:var(--c-surface);border:1px solid #e8e0d9;border-radius:12px;
  padding:.8rem .95rem;box-shadow:0 2px 6px rgba(0,0,0,.04);
  transition:transform .2s ease,box-shadow .2s ease,border-color .2s ease
}
.card:hover{transform:translateY(-2px);border-color:#d27b4b33;box-shadow:0 8px 18px rgba(210,123,75,.14)}
.card h3{margin:0 0 .35rem;color:#b35f37;font-size:1rem}

/* Callout / 引文 */
.callout{
  border-left:4px solid var(--c-primary);
  background:linear-gradient(180deg,#fffdf9,var(--c-soft));
  padding:.75rem .9rem;border-radius:10px;margin-top:.45rem;color:#6e5a50
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
