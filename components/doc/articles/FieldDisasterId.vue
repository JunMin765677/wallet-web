<!-- components/doc/articles/FieldDisasterId.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '在災害現場，社福身份能如何幫助快速辨識？',
  subtitle: '現場應用篇 / 救援優先序 × 即時驗證 × 選擇性揭露',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '現場應用篇', to: '/docs#field' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <section>
        <h2 id="s1">一、混亂中的盲點：誰需要被優先救援？</h2>
        <p>
          當災害發生時，第一線的消防、警察、里幹事與志工都在同一個問題中掙扎——
          <strong>誰是最需要立即協助的人？</strong>
          地震、淹水或火災現場中，民眾可能受傷、失聯、無法自述，而紙本資料、名冊或身分證件往往留在家裡、甚至被毀損。
        </p>
        <p>
          在這種情況下，「社會福利身份」其實是判斷援助優先順序的重要依據。例如：
        </p>
        <ul>
          <li>身障或臥床者需要特殊運送；</li>
          <li>低收入戶或單親家庭需要立即安置；</li>
          <li>老人、長照對象或慢性病患需要醫療支援與陪伴。</li>
        </ul>
        <p>
          但現行系統中，這些資料分散在不同局處（社會局、衛生局、長照中心），現場人員幾乎無法即時查得。
        </p>
      </section>

      <hr class="div" />

      <section>
        <h2 id="s2">二、數位憑證讓辨識更即時、行動化</h2>
        <p>
          若災害現場的救援系統能即時掃描一張民眾的<strong>社福數位憑證</strong>（連線運作下），就能在幾秒內從授權資料中辨識其必要身份資訊。
        </p>
        <ul class="bullets">
          <li>里幹事掃描避難民眾的憑證，可立即確認其是否為低收、身障或長照對象。</li>
          <li>救災中心可依據憑證標示的「身份別」或「福利等級」進行分流安排。</li>
          <li>系統能即時回傳匿名統計，協助社會局掌握安置與資源分配狀況。</li>
        </ul>
        <p>
          這讓「身份辨識」不再只是行政作業，而成為<strong>救援流程的一部分</strong>。數位憑證提供的，是一種能在現場快速確認「誰最需要幫助」的公共基礎能力。
        </p>
      </section>

      <hr class="div" />

      <section>
        <h2 id="s3">三、兼顧隱私與尊嚴：揭露「必要而不過度」的資訊</h2>
        <p>
          災害現場資訊傳遞速度快，但隱私風險也高。因此在設計上，憑證驗證結果僅顯示<strong>必要的狀態</strong>，而不揭露完整個資。例如：
        </p>

        <div class="checklist">
          <p>✅ 此人具備長照身份</p>
          <p>✅ 此人為低收入戶</p>
          <p>✅ 此人為身障者（不顯示細節）</p>
        </div>

        <p>
          透過<strong>選擇性揭露</strong>機制（如 SD-JWT / 結構化聲明），救援人員能在不接觸個資的前提下完成核實，讓民眾在接受援助的同時，也保有隱私與尊嚴。
        </p>
      </section>

      <hr class="div" />

      <section>
        <h2 id="s4">四、實際效益：讓災害應變更有秩序</h2>
        <ul class="bullets">
          <li><strong>減少誤判與重複登錄：</strong>即時驗證後即可確認身份，避免重複登記或遺漏。</li>
          <li><strong>跨單位協作更順暢：</strong>警消、社會局、醫療團隊可共用同一筆驗證結果。</li>
          <li><strong>形成即時決策資料：</strong>現場的驗證紀錄可回饋災後檢討與政策改善。</li>
          <li><strong>提升民眾信任感：</strong>被快速辨識與安置的過程，讓民眾感受到政府的準備與效率。</li>
        </ul>
      </section>

      <hr class="div" />

      <section>
        <h2 id="s5">五、展望：從「災後救援」走向「災前照護」</h2>
        <p>
          若未來能結合地方防災資料與社福身份憑證，當災害警報發出時，系統便能主動列出社區中需優先協助的名單，協助里長或防災隊提前部署。
        </p>
        <p class="callout">
          這不僅是災後救援的數位工具，更是一種<strong>災前預警與社福整合的新型基礎建設</strong>。在「暖心 e 證通」的想像中，這張卡片不只是身分證明，更是一種能讓協助「快一點、準一點」的信任媒介。
        </p>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post {
  --c-primary: #c96c3b;
  --c-accent: #e7b17d;
  --c-ink: #2b2b2b;
  --c-muted: #5a4e47;
  color: var(--c-ink);
  line-height: 1.8;
}

/* 標題樣式 */
.post h2 {
  margin: 1.15rem 0 .55rem;
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

/* 內文與列表 */
.post p { margin: .35rem 0 .75rem; }
.post ul { margin: .3rem 0 .9rem 1.25rem; }
.post li { margin: .2rem 0; }
.post strong { color: var(--c-muted); }

/* 分隔線 */
.div {
  border: 0;
  height: 1px;
  background: linear-gradient(90deg, #f0e6df, #ead8c8 40%, #f0e6df);
  margin: 1rem 0 1rem;
}

/* 勾選清單 */
.checklist {
  background: #fff8f2;
  border: 1px solid #f0e1d8;
  border-radius: 10px;
  padding: .6rem .75rem;
  margin: .4rem 0 .8rem;
}
.checklist p { margin: .15rem 0; }

/* 子彈點更易讀 */
.bullets li { padding-left: .2rem; }

/* 強調提示 */
.callout {
  margin-top: .6rem;
  border-left: 4px solid var(--c-primary);
  background: linear-gradient(180deg, #fffdf9, #fff8f2);
  padding: .65rem .85rem;
  border-radius: 8px;
}

/* RWD */
@media (max-width: 768px) {
  .post h2 { font-size: 1.05rem; }
}
</style>
