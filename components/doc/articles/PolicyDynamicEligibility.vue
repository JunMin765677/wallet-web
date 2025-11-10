<!-- components/doc/articles/PolicyDynamicEligibility.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '為什麼社會福利資格會頻繁變動？這對數位憑證代表什麼挑戰？',
  subtitle: '技術與政策篇 / 動態資格 × 撤銷狀態 × 持續信任',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '技術與政策篇', to: '/docs#policy' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- 一、社福身份是動態狀態 -->
      <section class="lead">
        <h2 id="s1">一、社福身份不是「一張卡」，而是一個不斷變動的狀態</h2>
        <p>
          社會福利資格由<strong>家庭結構、所得、資產、身體狀況</strong>等條件綜合決定，並會隨時間與事件改變。任何靜態「證明文件」都註定在短時間內失效。
        </p>
        <ul class="bullets">
          <li><strong>低收入戶資格：</strong>半年或一年複審；所得、資產、戶籍遷出皆可能影響。</li>
          <li><strong>身障等級：</strong>因鑑定、病況變化而升降。</li>
          <li><strong>老人津貼 / 特境補助：</strong>依稅務、婚姻、死亡登記異動。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 二、靜態資料困境 -->
      <section>
        <h2 id="s2">二、靜態資料的困境</h2>
        <p>傳統假設「核發＝當前有效」在社福領域並不成立，因為「符合資格」本身需要<strong>連續驗證</strong>。</p>
        <div class="grid2">
          <article class="card">
            <h3>常見風險</h3>
            <ul class="tick">
              <li>紙本永遠落後於現況。</li>
              <li>實體卡仍可能在系統內已失效。</li>
              <li>有效期越長，錯發與冒領風險越高。</li>
            </ul>
          </article>
          <article class="card">
            <h3>運作成本</h3>
            <ul class="tick">
              <li>無法定期比對 → 行政負擔轉嫁到第一線。</li>
              <li>跨系統人工核對 → 稽核追溯困難。</li>
            </ul>
          </article>
        </div>
      </section>

      <hr class="div" />

      <!-- 三、VC 的三大挑戰 -->
      <section>
        <h2 id="s3">三、數位憑證的挑戰：如何讓動態變化不破壞信任？</h2>

        <div class="table-wrap">
          <table class="cmp">
            <thead>
              <tr>
                <th scope="col">挑戰</th>
                <th scope="col">核心問題</th>
                <th scope="col">建議作法</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row">即時性</th>
                <td>簽發只是「狀態快照」，如何接近現況？</td>
                <td>事件觸發或排程式<strong>重新簽發</strong>；設定<strong>短週期有效期</strong>與<strong>Grace Period</strong>。</td>
              </tr>
              <tr>
                <th scope="row">可信鏈</th>
                <td>不揭露個資的情況下，如何反映變動？</td>
                <td>導入<strong>狀態檢查（Status Check）</strong>與<strong>撤銷清單（Revocation List）</strong>；最小揭露回應「仍有效」。</td>
              </tr>
              <tr>
                <th scope="row">制度</th>
                <td>誰負責發？誰負責撤？異常誰決策？</td>
                <td>明確<strong>權責切分</strong>（發證/撤銷/申訴）；建立<strong>SLA 與稽核流程</strong>。</td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>

      <hr class="div" />

      <!-- 四、從一次證明到持續信任 -->
      <section>
        <h2 id="s4">四、從「一張證」轉向「持續信任」</h2>
        <p>將憑證視為<strong>即時信任節點</strong>，而非長期不變的「卡」。</p>
        <div class="table-wrap">
          <table class="cmp alt">
            <thead>
              <tr><th>傳統證明</th><th>數位憑證新模式</th></tr>
            </thead>
            <tbody>
              <tr><td>一次核發，長期使用</td><td>定期同步、事件觸發重新簽發</td></tr>
              <tr><td>靜態資料、人工比對</td><td>自動驗證、狀態查詢（最小揭露）</td></tr>
              <tr><td>憑證有效＝身份有效</td><td>憑證有效 + 狀態有效 ＝ 信任有效</td></tr>
              <tr><td>單一責任</td><td>分散式權限管理、動態授權</td></tr>
            </tbody>
          </table>
        </div>

        <div class="callout">
          <p><strong>設計要點：</strong>把「是否仍有效」做成可驗證的狀態，不把「為什麼有效」到處傳。</p>
        </div>
      </section>

      <hr class="div" />

      <!-- 五、技術侷限與政策平衡 -->
      <section>
        <h2 id="s5">五、技術的侷限與政策的平衡</h2>
        <p>理想上可用 API/Webhook 即時更新，但現實中最大瓶頸常在資料治理與跨局處協調。</p>
        <ul class="bullets">
          <li>稅務、社福、戶政系統更新週期不一致。</li>
          <li>縣市標準不一，欄位/定義難以統一。</li>
          <li>許多異動需人工核定或文件佐證。</li>
        </ul>
        <p class="note">因此，導入 VC 同步需要<strong>技術規格 + 政策協定</strong>並重，將更新頻率與責任界線制度化。</p>
      </section>

      <hr class="div" />

      <!-- 六、落地藍圖（參考） -->
      <section>
        <h2 id="s6">六、落地藍圖（參考）</h2>
        <ol class="flow">
          <li><span>定義狀態模型</span><small>（有效/撤銷/複審中/待補）</small></li>
          <li><span>建立事件來源</span><small>（戶政、稅務、醫療鑑定）</small></li>
          <li><span>事件觸發簽發/撤銷</span><small>（Webhook/排程）</small></li>
          <li><span>驗證端狀態查詢</span><small>（最小揭露：「此證仍有效」）</small></li>
          <li><span>稽核與申訴</span><small>（留跡不可識別、可追溯）</small></li>
        </ol>
      </section>

      <hr class="div" />

      <!-- 七、小結 -->
      <section class="wrapup">
        <h2 id="s7">七、小結：社福不是靜態身份，而是動態關係</h2>
        <p>
          數位憑證的課題不在於「一次核發」，而在於「與現實持續對話」。要讓 VC 誠實反映現況，除了可撤銷、可查狀態的技術設計，
          更需要清晰的權責、更新週期與稽核機制。如此，信任才能在變動中長期維持。
        </p>
        <blockquote class="quote">
          真正的可驗證憑證，不是簽一次就永遠正確的卡，<br>而是能與現實同步的信任網。
        </blockquote>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post{
  --c-ink:#2b2b2b;
  --c-muted:#5a4e47;
  --c-primary:#b35f37;  /* 與全站米白背景協調的暖色系 */
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

/* 視覺分隔線 */
.div{
  border:0;height:1px;
  background:linear-gradient(90deg,#f0e6df,var(--c-line) 40%,#f0e6df);
  margin:1rem 0 1rem;
}

/* 卡片 & 網格 */
.grid2{display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:.85rem;margin-top:.35rem}
.card{
  background:var(--c-surface);border:1px solid #e8e0d9;border-radius:12px;
  padding:.8rem .95rem;box-shadow:0 2px 6px rgba(0,0,0,.04);
  transition:transform .2s ease,box-shadow .2s ease,border-color .2s ease
}
.card:hover{transform:translateY(-2px);border-color:#d27b4b33;box-shadow:0 8px 18px rgba(210,123,75,.14)}
.card h3{margin:0 0 .35rem;color:#b35f37;font-size:1rem}

/* 對照表 */
.table-wrap{overflow-x:auto;border:1px solid #efe6de;border-radius:12px;background:#fff;margin-top:.35rem}
.cmp{width:100%;min-width:620px;border-collapse:collapse}
.cmp thead th{
  text-align:left;font-weight:700;font-size:.92rem;color:#835b46;
  background:#fff7f0;border-bottom:1px solid var(--c-line);padding:.55rem .7rem
}
.cmp tbody th{font-weight:700;color:#6e4b38}
.cmp tbody td,.cmp tbody th{padding:.55rem .7rem;border-bottom:1px solid #f2e7dd;vertical-align:top}
.cmp.alt tbody td,.cmp.alt tbody th{background:#fff}

/* 勾選清單 */
.tick{margin:.35rem 0 .9rem 1.25rem}
.tick li{list-style:none;position:relative;padding-left:1.25rem;margin:.22rem 0}
.tick li::before{content:"✔";position:absolute;left:0;top:.1rem;color:var(--c-primary)}

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
  padding:.75rem .9rem;border-radius:10px;margin-top:.45rem
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
