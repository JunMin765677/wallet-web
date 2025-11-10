<!-- components/doc/articles/FieldWhyLocalId.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '為什麼里長或里幹事需要一個能掃的「數位身份」？',
  subtitle: '現場應用篇 / 即時驗證 × 最小揭露 × 行動服務',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '現場應用篇', to: '/docs#field' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <!-- 文章內文：本檔使用 scoped 樣式，僅作用於此篇 -->
    <article class="post">
      <h2 id="sec-1">一、現場的困難：資訊不通、設備不足、驗證冗長</h2>
      <p>
        在社會局、里辦公處或災害現場，里幹事與社工經常是第一個面對民眾的人。
        但他們手上沒有完整的資訊系統，也無法即時查驗民眾的社福身份。
      </p>
      <p>實際場景中常見的問題包括：</p>
      <ul>
        <li>里幹事外出訪查時，無法連上政府內網；</li>
        <li>民眾說自己是「中低收入戶」或「身障人士」，但無法當下證明；</li>
        <li>善心機構需要核對資格名單，但社會局無法提供（因涉及個資法）；</li>
        <li>臨時災害現場（如颱風、火災、地震安置點），無法快速辨識誰需要優先協助。</li>
      </ul>
      <p>
        結果就是：資訊被困在不同的系統裡、查證靠紙本、公務員必須手動比對，
        讓社福現場變成一場「信任的考試」——不是每個人說的都能馬上被相信。
      </p>

      <hr class="div" />

      <h2 id="sec-2">二、數位憑證如何改變這件事</h2>
      <p>有了「可掃描的數位身份憑證」，現場驗證可以變得即時又精準。</p>
      <ol>
        <li><strong>個資不外露：</strong>驗證方只知道民眾「是否具備資格」，而非完整個資。</li>
        <li><strong>快速比對：</strong>QR Code 或 VC Token 中的資料與政府端簽章匹配即可確認身份。</li>
        <li><strong>行動裝置即可操作：</strong>不需要大型設備、VPN 或專線，讓「行動服務」真正可行。</li>
      </ol>
      <p>
        對第一線人員而言，這意味著可以「帶著手機就開工」：在巷口發物資、在避難中心開表單、在家訪途中確認身份，
        都不再需要回到辦公室開系統查人。
      </p>

      <hr class="div" />

      <h2 id="sec-3">三、從「查核」變成「信任」</h2>
      <p>
        這樣的數位工具不只是加快流程，它更改變了服務關係的氛圍。過去的社福訪查，民眾常感到被懷疑；
        現在只要掃描一下憑證，結果清楚透明，雙方都能省去解釋、比對與尷尬的過程。
      </p>
      <p>
        對服務人員而言，也能避免誤發、漏發或被冒領的風險。對民眾而言，這是一種被信任與被尊重的體驗。
      </p>

      <hr class="div" />

      <h2 id="sec-4">四、潛在影響：</h2>
      <ul class="bullets">
        <li><strong>效率提升：</strong>減少現場等待與回報時間，節省行政成本。</li>
        <li><strong>資訊一致：</strong>不同單位之間可共用驗證結果，不必重複登錄。</li>
        <li><strong>服務精準：</strong>透過驗證紀錄分析，可更清楚掌握社福資源的實際使用情況。</li>
        <li><strong>公信提升：</strong>透明的數位驗證流程，能讓民眾更信任公部門。</li>
      </ul>

      <hr class="div" />

      <h2 id="sec-5">五、未來展望</h2>
      <p>
        當第一線的里幹事、社工與慈善團體都能即時驗證身份時，社會服務的觸角就能更靈活地延伸到真正需要的地方。
        而「暖心 e 證通」要做的，不只是讓系統變得數位，而是讓服務變得更人性化——讓信任，不再被距離與紙本拖慢。
      </p>
    </article>
  </ArticleFrame>
</template>

<style scoped>
/* 僅此篇適用的暖系版面微樣式 */
.post {
  --c-primary: #c96c3b;
  --c-accent: #e7b17d;
  --c-ink: #2b2b2b;
  --c-muted: #5a4e47;
  color: var(--c-ink);
  line-height: 1.8;
}

/* 標題層級 */
.post h2 {
  margin: 1.15rem 0 .5rem;
  font-size: 1.1rem;
  color: var(--c-primary);
  display: inline-flex;
  align-items: center;
  gap: .4rem;
}
.post h2::before {
  content: "";
  width: 10px; height: 10px; border-radius: 50%;
  background: radial-gradient(circle at 40% 40%, var(--c-accent), var(--c-primary));
  display: inline-block;
}

/* 文字與列表 */
.post p { margin: .35rem 0 .75rem; }
.post ul, .post ol { margin: .3rem 0 .9rem 1.25rem; }
.post li { margin: .2rem 0; }
.post strong { color: var(--c-muted); }

/* 分隔線 */
.div {
  border: 0;
  height: 1px;
  background: linear-gradient(90deg, #f0e6df, #ead8c8 40%, #f0e6df);
  margin: 1rem 0 1rem;
}

/* 重點列舉更清楚 */
.bullets li { padding-left: .2rem; }

/* RWD 微調 */
@media (max-width: 768px) {
  .post h2 { font-size: 1.05rem; }
}
</style>
