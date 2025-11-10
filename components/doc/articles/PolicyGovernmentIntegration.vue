<!-- components/doc/articles/PolicyGovernmentIntegration.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '政府資料庫能直接介接 VC 嗎？需要哪些安全防線？',
  subtitle: '技術與政策篇 / 資料治理 × 三層防線 × 可審計信任',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '技術與政策篇', to: '/docs#policy' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- 一、直覺與現實的落差 -->
      <section class="lead">
        <h2 id="s1">一、直覺與現實的落差</h2>
        <p>
          「政府資料庫介接數位憑證」看似理所當然；但事實上政府是由<strong>成百上千個分散系統</strong>構成，
          權責、法源、欄位與更新週期皆不一致，介接挑戰的是整體<strong>資料治理</strong>，不是單一 API。
        </p>

        <div class="table-wrap">
          <table class="cmp">
            <thead>
              <tr>
                <th scope="col">系統名稱</th>
                <th scope="col">管轄單位</th>
                <th scope="col">資料內容</th>
                <th scope="col">更新週期</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row">戶政系統</th>
                <td>內政部</td>
                <td>家庭、婚姻、身分資料</td>
                <td>即時</td>
              </tr>
              <tr>
                <th scope="row">財稅系統</th>
                <td>財政部</td>
                <td>所得、財產</td>
                <td>年度</td>
              </tr>
              <tr>
                <th scope="row">勞保系統</th>
                <td>勞保局</td>
                <td>投保與薪資紀錄</td>
                <td>月度</td>
              </tr>
              <tr>
                <th scope="row">社福系統</th>
                <td>各縣市社會局</td>
                <td>福利申請與核定資料</td>
                <td>不定期（含人工）</td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>

      <hr class="div" />

      <!-- 二、為什麼不能「直接介接」 -->
      <section>
        <h2 id="s2">二、為什麼不能「直接介接」？</h2>
        <div class="grid3">
          <article class="card">
            <h3>① 法制限制</h3>
            <p>跨系統取用必須有法源或契約；社福與個資屬高度敏感資料，無法以「預設開放」處理。</p>
          </article>
          <article class="card">
            <h3>② 責任不明</h3>
            <p>簽發錯誤、不同步、資料爭議時，若權責未切分，風險無人承擔。</p>
          </article>
          <article class="card">
            <h3>③ 資安風險</h3>
            <p>簽發端直連主資料庫＝每次簽發都是一次外洩風險點，違背去中心化信任精神。</p>
          </article>
        </div>
      </section>

      <hr class="div" />

      <!-- 三、安全介接的三層設計 -->
      <section>
        <h2 id="s3">三、安全介接的三層設計（Three-Tier Trust Gateway）</h2>
        <ol class="flow">
          <li>
            <span>資料隔離層（Data Isolation）</span>
            <small>資料擁有機關輸出「資料視圖」，只提供必要欄位與狀態；從「資料共享」改為「結果共享」。</small>
          </li>
          <li>
            <span>簽章授權層（Issuance Gateway）</span>
            <small>統一簽章與簽發紀錄；檢核資格、加上 Issuer DID、寫入撤銷鏈。</small>
          </li>
          <li>
            <span>狀態查核層（Status & Revocation）</span>
            <small>提供不含個資的狀態查詢端點，驗證方僅確認「仍有效/已撤銷」。</small>
          </li>
        </ol>

        <div class="callout">
          <p><strong>關鍵觀念：</strong>讓資料可用、可控、可審計；而非開放直接讀取主資料庫。</p>
        </div>
      </section>

      <hr class="div" />

      <!-- 四、防線一：簽章責任與金鑰管理 -->
      <section>
        <h2 id="s4">四、防線一：簽章責任與金鑰管理</h2>
        <ul class="tick">
          <li>建立 Issuer Key Management Policy（分層金鑰、定期輪替）。</li>
          <li>私鑰託管於 HSM；所有簽章保留不可抵賴審計軌跡。</li>
          <li>金鑰失竊時：快速撤銷、重建信任鏈、廣播新公鑰。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 五、防線二：最小揭露與授權紀錄 -->
      <section>
        <h2 id="s5">五、防線二：最小揭露與授權紀錄</h2>
        <div class="table-wrap">
          <table class="cmp alt">
            <thead>
              <tr>
                <th>原則</th>
                <th>落地作法</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>最小揭露</td>
                <td>只回傳驗證所需欄位（例如：<em>資格有效</em> / <em>等級 ≥ 中度</em>）。</td>
              </tr>
              <tr>
                <td>有痕透明</td>
                <td>每次取用均有授權與資料請求紀錄，包含主體、事由、時間、欄位。</td>
              </tr>
              <tr>
                <td>可稽核</td>
                <td>發證端、查詢端、驗證端全鏈路審計，支援事件回放與追溯。</td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>

      <hr class="div" />

      <!-- 六、防線三：沙盒驗證與模擬測試 -->
      <section>
        <h2 id="s6">六、防線三：沙盒驗證與模擬測試</h2>
        <ul class="bullets">
          <li>以匿名化/合成資料建立 Sandbox；模擬簽發、撤銷、狀態查核流程。</li>
          <li>驗證 API 權限邏輯與錯誤處理（逾時、不同步、撤銷衝突）。</li>
          <li>多機關聯測：在不接觸真實資料前提下完成串接驗證。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 七、常見誤區 → 建議模式 -->
      <section>
        <h2 id="s7">七、從誤區到建議模式</h2>
        <div class="grid2">
          <article class="card wrong">
            <h3>常見誤區</h3>
            <ul>
              <li>簽發端直連主資料庫查詢。</li>
              <li>以批次匯出 CSV/Excel 作為準同步機制。</li>
              <li>驗證端要求完整個資以自保。</li>
            </ul>
          </article>
          <article class="card right">
            <h3>建議模式</h3>
            <ul>
              <li>資料視圖 API + 權限控管（結果共享）。</li>
              <li>簽章閘道統一簽發與撤銷登錄。</li>
              <li>狀態查核端點供驗證（不見個資）。</li>
            </ul>
          </article>
        </div>
      </section>

      <hr class="div" />

      <!-- 八、小結：介接不是打通，而是劃界 -->
      <section class="wrapup">
        <h2 id="s8">八、小結：介接不是打通，而是劃界</h2>
        <p>
          核心不是「能不能讀」，而是「如何<strong>只讀必要部分</strong>且<em>可審計</em>」。真正的開放不是人人直連主庫，
          而是每一次存取都能回答：<strong>誰、為什麼、看了什麼</strong>。
        </p>
        <blockquote class="quote">
          讓資料流動更有邊界，讓信任可以被驗證——這才是政府 × VC 的正確介接方式。
        </blockquote>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post{
  --c-ink:#2b2b2b;
  --c-muted:#5a4e47;
  --c-primary:#b35f37;  /* 暖棕紅，呼應米白背景 */
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

/* 文本與列表 */
.post p{margin:.35rem 0 .75rem}
.bullets{margin:.35rem 0 .9rem 1.25rem}
.bullets li{margin:.22rem 0}

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
.cmp tbody th{font-weight:700;color:#6e4b38}
.cmp tbody td,.cmp tbody th{padding:.55rem .7rem;border-bottom:1px solid #f2e7dd;vertical-align:top}
.cmp.alt tbody td,.cmp.alt tbody th{background:#fff}

/* 卡片 */
.grid2{display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:.85rem;margin-top:.35rem}
.grid3{display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:.85rem;margin-top:.35rem}
.card{
  background:var(--c-surface);border:1px solid #e8e0d9;border-radius:12px;
  padding:.8rem .95rem;box-shadow:0 2px 6px rgba(0,0,0,.04);
  transition:transform .2s ease,box-shadow .2s ease,border-color .2s ease
}
.card:hover{transform:translateY(-2px);border-color:#d27b4b33;box-shadow:0 8px 18px rgba(210,123,75,.14)}
.card h3{margin:0 0 .35rem;color:#b35f37;font-size:1rem}
.card.wrong{border-color:#f3c1b4;background:#fff6f3}
.card.right{border-color:#bfe3d0;background:#f4fbf7}

/* 勾選清單與流程帶 */
.tick{margin:.35rem 0 .9rem 1.25rem}
.tick li{list-style:none;position:relative;padding-left:1.25rem;margin:.22rem 0}
.tick li::before{content:"✔";position:absolute;left:0;top:.1rem;color:var(--c-primary)}
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

/* RWD 微調 */
@media (max-width:768px){
  .post h2{font-size:1.06rem}
}
</style>
