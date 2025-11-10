<!-- components/doc/articles/PolicyAuditability.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '憑證簽發與驗證要如何被審計？是否會增加行政負擔？',
  subtitle: '技術與政策篇 / 稽核可追溯 × 匿名不侵擾 × 降低負擔',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '技術與政策篇', to: '/docs#policy' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- 一、信任的第二層 -->
      <section class="lead">
        <h2 id="s1">一、從「簽發」到「審計」：信任的第二層</h2>
        <p>
          傳統審計強調<strong>文件可追蹤</strong>；進入數位憑證（VC）時代，文件變成資料流，但核心原則不變——
          必須<strong>可稽核、可回溯、可驗證</strong>。不同的是：VC 由個人持有、跨機構互信，審計不能侵入內容，也不能複製副本。
        </p>
        <p class="note">問題不是「把資料交出來」，而是「讓流程能被驗證」。</p>
      </section>

      <hr class="div" />

      <!-- 二、審計目的 -->
      <section>
        <h2 id="s2">二、審計的目的：不是監控，而是確保信任鏈沒有斷</h2>
        <p>審計的對象不是憑證內容，而是<strong>憑證生命週期</strong>：</p>
        <ul class="tick">
          <li>誰簽發了憑證？（Issuer）</li>
          <li>依據什麼政策？（Policy）</li>
          <li>是否正確撤銷/更新？（Revocation / Status）</li>
          <li>誰進行了驗證？（Verifier）</li>
          <li>驗證結果為何？（Result）</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 三、三層式稽核模型 -->
      <section>
        <h2 id="s3">三、VC 審計的三種記錄層級</h2>
        <div class="grid3">
          <article class="card">
            <h3>① 系統層稽核（System Audit）</h3>
            <ul>
              <li>記錄 API 請求、簽章、撤銷、驗證等事件。</li>
              <li>欄位：timestamp、actor（金鑰辨識）、action、result。</li>
              <li>用途：資安監控與系統健康，<strong>不含個資</strong>。</li>
            </ul>
          </article>
          <article class="card">
            <h3>② 政策層稽核（Policy Audit）</h3>
            <ul>
              <li>映射「此張 VC 依據哪一版政策簽發」。</li>
              <li>範例：低收 VC 對應某條文/命令之版本。</li>
              <li>用途：合規可驗證、避免主觀裁量。</li>
            </ul>
          </article>
          <article class="card">
            <h3>③ 匿名化紀錄層（Anonymized Trace）</h3>
            <ul>
              <li>欄位建議：vc_hash、issuer_id、issue_time、revoke_time、verifier_id、verify_result。</li>
              <li>以哈希/去識別方式呈現生命週期統計。</li>
              <li>用途：分析信任指標，<strong>不揭露個資</strong>。</li>
            </ul>
          </article>
        </div>
      </section>

      <hr class="div" />

      <!-- 四、負擔比較 -->
      <section>
        <h2 id="s4">四、常見疑慮：會不會增加行政負擔？</h2>
        <p>正確導入後，稽核反而<strong>減少</strong>人工負擔：</p>
        <div class="table-wrap">
          <table class="cmp alt">
            <thead>
              <tr>
                <th>傳統流程</th>
                <th>VC 架構下</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>人工簽章、歸檔、找文件</td>
                <td>自動簽章、事件留軌、UUID/CID 直查</td>
              </tr>
              <tr>
                <td>紙本/系統紀錄人工比對</td>
                <td>稽核查驗簽章與事件鏈，不需收集文件</td>
              </tr>
              <tr>
                <td>多系統對時困難</td>
                <td>DID/事件標準化，跨機關可共用稽核格式</td>
              </tr>
              <tr>
                <td>錯誤回溯費時</td>
                <td>事件索引可快速溯源（issue → verify → revoke）</td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>

      <hr class="div" />

      <!-- 五、防止「稽核變監控」 -->
      <section>
        <h2 id="s5">五、如何避免稽核變成「監控」？</h2>
        <div class="grid3">
          <article class="card">
            <h3>事件匿名化</h3>
            <p>對可識別欄位進行 Hash/鹽化處理，避免還原個人身份。</p>
          </article>
          <article class="card">
            <h3>權限分離</h3>
            <p>稽核單位僅可存取統計層級；個案資訊需法定程序。</p>
          </article>
          <article class="card">
            <h3>去識別報表</h3>
            <p>以趨勢/比例呈現，不提供逐筆可識別紀錄。</p>
          </article>
        </div>
        <div class="callout">
          <p><strong>原則：</strong>保留問責力，但不建立被動監控。</p>
        </div>
      </section>

      <hr class="div" />

      <!-- 六、制度落地建議 -->
      <section>
        <h2 id="s6">六、制度上的落地建議</h2>
        <ol class="flow">
          <li><span>制定 VC 稽核準則</span><small>範圍、格式、留存期限、抽查機制。</small></li>
          <li><span>統一事件結構</span><small>採用通用事件 Schema（例：OpenAudit-like）。</small></li>
          <li><span>建立稽核 API</span><small>提供匿名化統計抓取，取代人工報表。</small></li>
          <li><span>與資安年報整合</span><small>以系統健康度呈現，而非逐筆審查。</small></li>
        </ol>
      </section>

      <hr class="div" />

      <!-- 七、小結 -->
      <section class="wrapup">
        <h2 id="s7">七、小結：從「追蹤文件」到「追蹤信任」</h2>
        <p>
          在 VC 架構中，真正被審計的不是資料內容，而是<strong>信任如何被建立、維護與更新</strong>。
          當簽發、使用與撤銷皆有跡可循，信任不再仰賴人，而由系統自證其正確。
        </p>
        <blockquote class="quote">
          讓稽核服務於信任，而不是侵犯隱私。<br />
          追蹤的是流程，不是個人。
        </blockquote>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post{
  --c-ink:#2b2b2b;
  --c-muted:#5a4e47;
  --c-primary:#b35f37;  /* 暖棕紅，搭配米白背景 */
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
.cmp{width:100%;min-width:620px;border-collapse:collapse}
.cmp thead th{
  text-align:left;font-weight:700;font-size:.92rem;color:#835b46;
  background:#fff7f0;border-bottom:1px solid var(--c-line);padding:.55rem .7rem
}
.cmp tbody td,.cmp tbody th{padding:.55rem .7rem;border-bottom:1px solid #f2e7dd;vertical-align:top}
.cmp.alt tbody td,.cmp.alt tbody th{background:#fff}

/* 卡片網格 */
.grid3{display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:.85rem;margin-top:.35rem}
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
  padding:.45rem .8rem .45rem 2rem;box-shadow:0 2px 6px rgba(0,0,0,.04)
}
.flow li::before{
  content:counter(step);
  position:absolute;left:.55rem;top:50%;transform:translateY(-50%);
  width:1.2rem;height:1.2rem;border-radius:50%;
  display:inline-flex;align-items:center;justify-content:center;
  background:#fff1e5;border:1px solid #f0dfd3;color:#8b6a56;font-weight:700;font-size:.82rem
}
.flow small{color:#8a7569;margin-left:.35rem}

/* Callout / 引文 */
.callout{
  border-left:4px solid var(--c-primary);
  background:linear-gradient(180deg,#fffdf9,var(--c-soft));
  padding:.75rem .9rem;border-radius:10px;margin-top:.45rem
}
.quote{
  background:#fff;border:1px solid #e8e0d9;border-radius:12px;
  padding:.85rem 1rem;color:#583d30;box-shadow:0 2px 6px rgba(0,0,0,.04);margin-top:.45rem
}

/* RWD */
@media (max-width:768px){
  .post h2{font-size:1.06rem}
}
</style>
