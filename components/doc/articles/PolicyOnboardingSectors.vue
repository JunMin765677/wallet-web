<!-- components/doc/articles/PolicyOnboardingSectors.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '如果要在醫院、長照機構、律師事務所導入 VC，要先克服什麼？',
  subtitle: '技術與政策篇 / 法源 × 流程 × 技術 × 文化',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '技術與政策篇', to: '/docs#policy' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- 一、現實情境 -->
      <section class="lead">
        <h2 id="s1">一、現實情境：每個單位都在「用資料」，但方式不同</h2>
        <p>
          醫院、長照中心、律師事務所都需要驗證當事人身份，但彼此的信任鏈<strong>不存在</strong>。
          醫院看重醫療與補助資格；長照關心照護等級與家庭支持；律所需確定身分真偽與法扶資格。
          各自握有片段資訊，卻<strong>缺乏合法、即時的互通</strong>。
        </p>
        <p>
          數位憑證（VC）可以打通這個斷點，但必須跨過四個門檻：<strong>法源、流程、技術、文化</strong>。
        </p>
      </section>

      <hr class="div" />

      <!-- 二、法源依據 -->
      <section>
        <h2 id="s2">二、第一個門檻：法源依據</h2>
        <h3 class="sub">問題：他們能合法驗證嗎？</h3>
        <p>
          在《個資法》、《醫療法》、《律師法》等規範下，多數單位沒有直接查驗他人社福身份的權限。
          技術可行不代表行為合法，否則即構成越權處理個資。
        </p>
        <h3 class="sub">可行方向</h3>
        <ul class="tick">
          <li>
            建立<strong>授權驗證制度</strong>：由主管機關核發驗證資格，通過者方可使用政府簽章的 VC 驗證 API。
          </li>
          <li>
            以<strong>使用目的</strong>為界（如醫療補助、法扶審核），限定驗證用途與範圍，留下稽核軌跡。
          </li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 三、流程整合 -->
      <section>
        <h2 id="s3">三、第二個門檻：流程整合</h2>
        <h3 class="sub">問題：技術上可用，但實務上難導</h3>
        <p>
          第一線人員沒有時間開 App、掃碼、重複登入；他們需要的是
          <em>一鍵得知能不能幫</em>。流程若冗長，制度便會在現場被放棄。
        </p>
        <h3 class="sub">可行方向</h3>
        <ul class="tick">
          <li><strong>嵌入既有系統</strong>：把驗證功能放進 HIS、長照管理系統、法扶接案平台。</li>
          <li><strong>提供驗證元件/SDK</strong>：以嵌入式模組回傳「是／否／等級」結果。</li>
          <li><strong>一鍵式體驗</strong>：民眾掃碼 → 系統自動比對 → 只顯示結果，不暴露資料。</li>
        </ul>
        <div class="callout">原則：只有融入日常業務，技術才會被使用。</div>
      </section>

      <hr class="div" />

      <!-- 四、技術能力與維運 -->
      <section>
        <h2 id="s4">四、第三個門檻：技術能力與維運成本</h2>
        <h3 class="sub">問題：不是每個單位都有資安與 IT 團隊</h3>
        <p>
          小型機構難以自管金鑰、簽章、狀態查核與伺服器維運；若門檻過高，導入將只發生在少數大機構。
        </p>
        <h3 class="sub">可行方向</h3>
        <ul class="tick">
          <li><strong>Verification-as-a-Service</strong>：以雲端驗證代理提供簡化 API，免自建後端。</li>
          <li><strong>責任邊界清晰</strong>：由授權中介執行驗證，小機構只負責使用與留痕。</li>
          <li><strong>標準化 SDK</strong>：前端可直接嵌入，降低導入難度與維運成本。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 五、文化與信任 -->
      <section>
        <h2 id="s5">五、第四個門檻：文化與信任</h2>
        <h3 class="sub">問題：機構之間不敢互信，也怕出錯</h3>
        <p>
          目前缺乏<strong>共享信任</strong>的文化——「要自己查、不要相信別人提供的」。
          任何分散式信任架構若沒有共識，就難以落地。
        </p>
        <h3 class="sub">可行方向</h3>
        <ul class="tick">
          <li><strong>信任名錄（Trust List）</strong>：政府管理具驗證資格的機構清單，供各端參照。</li>
          <li><strong>「稽核而非監控」</strong>：驗證≠揭露資料；用匿名化與事件留痕維持問責。</li>
          <li><strong>示範場域</strong>：社會局 × 醫院試點，讓第一線體驗「資料更少、效率更高」。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 六、從導入到共存 -->
      <section>
        <h2 id="s6">六、從「導入」到「共存」：不要替代，要補足</h2>
        <p>
          VC 的目標不是取代現有系統，而是<strong>補足信任缺口</strong>。在高風險場域，它讓不同機構能安全地相信彼此：
        </p>
        <blockquote class="quote">
          醫院不用知道你的全部資料，卻能確定你有資格領補助；<br />
          律師不必看到你的財稅資料，卻能確認你符合法扶條件。
        </blockquote>
      </section>

      <hr class="div" />

      <!-- 七、小結 -->
      <section class="wrapup">
        <h2 id="s7">七、小結：從技術導入到信任共識</h2>
        <p>
          在醫院、長照、法律場域導入 VC，關鍵不在技術，而在<strong>制度與信任的重新設計</strong>：
          <strong>法源授權</strong>（讓驗證合法）、
          <strong>流程整合</strong>（讓使用順手）、
          <strong>技術中介</strong>（讓導入容易）、
          <strong>文化建立</strong>（讓彼此信任）。
        </p>
        <p>
          當這四層穩固後，VC 才能成為一種新的社會契約——在不揭露資料的情況下，協助弱勢、守住信任。
        </p>
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
.sub{margin:.25rem 0 .3rem;color:#7a4e3a;font-weight:600;font-size:.98rem}
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
.callout{
  border-left:4px solid var(--c-primary);
  background:linear-gradient(180deg,#fffdf9,var(--c-soft));
  padding:.7rem .9rem;border-radius:10px;margin-top:.45rem;color:#6e5a50
}

/* 分隔線 */
.div{
  border:0;height:1px;
  background:linear-gradient(90deg,#f0e6df,var(--c-line) 40%,#f0e6df);
  margin:1rem 0 1rem;
}

/* 引文 */
.quote{
  background:#fff;border:1px solid #e8e0d9;border-radius:12px;
  padding:.85rem 1rem;color:#583d30;box-shadow:0 2px 6px rgba(0,0,0,.04);margin-top:.45rem
}

/* RWD */
@media (max-width:768px){
  .post h2{font-size:1.06rem}
}
</style>
