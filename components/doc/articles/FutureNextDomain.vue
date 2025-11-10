<!-- components/doc/articles/FutureNextDomain.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '當社福身份都能用 VC 管理後，下一個能被改變的是什麼？',
  subtitle: '延伸思考篇 / 從「身份卡」到「社會狀態 API」',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '延伸思考篇', to: '/docs#future' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- 一 -->
      <section class="lead">
        <h2 id="s1">一、當「身份」不再只是紙本，而是一種動態狀態</h2>
        <p>
          當社福資格以 VC（可驗證憑證）存在後，身份不再是靜態標籤，而是可隨時間與情境更新的<strong>「社會狀態 API」</strong>。各機關能即時確認「這位民眾的現況是否最新」。
        </p>
        <ul class="tick">
          <li>低收入戶：半年／年度複審 → 狀態即時同步</li>
          <li>身障等級：鑑定變動 → 憑證狀態隨之更新</li>
          <li>長照資格：期滿或升降級 → 觸發重新簽發／撤銷</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 二 -->
      <section>
        <h2 id="s2">二、從「證明我有資格」到「系統主動協助」</h2>
        <p>憑證可驗證化之後，服務可由「被動申請」轉為「主動推送」。</p>
        <ul>
          <li>健保雲端比對到你符合長照補助 → App 推送「可申請長照補助」。</li>
          <li>戶籍或新生兒事件被偵測 → 直接推播托育／就學補助指引。</li>
        </ul>
        <p class="note">本質轉變：從「證明給政府看」到「政府主動照顧你」。</p>
      </section>

      <hr class="div" />

      <!-- 三 -->
      <section>
        <h2 id="s3">三、下一步可能被改變的場域</h2>
        <div class="grid">
          <div class="card">
            <h3>教育</h3>
            <ul>
              <li>學籍／學歷／結訓以 VC 表示，跨校免紙本驗證。</li>
              <li>學習歷程即時可驗、可攜、可授權。</li>
            </ul>
          </div>
          <div class="card">
            <h3>醫療與長照</h3>
            <ul>
              <li>補助資格、照護等級以 VC 出示；家屬受限度授權。</li>
              <li>場域即時驗證，減少掛號、核銷摩擦。</li>
            </ul>
          </div>
          <div class="card">
            <h3>就業與培訓</h3>
            <ul>
              <li>技術士證、專業證照 VC 化；招募掃碼即核驗。</li>
              <li>縮短人工查核與造假風險。</li>
            </ul>
          </div>
          <div class="card">
            <h3>災害與急難救助</h3>
            <ul>
              <li>受災戶資格 VC 驗證，現場分流與資源發放更即時。</li>
              <li>匿名統計回饋災後檢討。</li>
            </ul>
          </div>
          <div class="card">
            <h3>社會信用與金融</h3>
            <ul>
              <li>將公共信任資料（志工、遵規紀錄）VC 化。</li>
              <li>金融端依驗證結果提供低風險產品。</li>
            </ul>
          </div>
        </div>
      </section>

      <hr class="div" />

      <!-- 四 -->
      <section>
        <h2 id="s4">四、從「領取補助」到「參與治理」</h2>
        <p>
          VC 不僅是身份證明，更可成為公共參與的載具：志工服務、社區參與、培訓投入皆可形成
          <strong>「公共參與 VC」</strong>，作為政策加分與社會激勵依據。
        </p>
      </section>

      <hr class="div" />

      <!-- 五 -->
      <section>
        <h2 id="s5">五、風險與警訊：當「資料整合」變成「資料集中」</h2>
        <p>設計不當可能導致交叉比對與標籤化。需遵守下列原則：</p>
        <ul class="tick">
          <li><strong>資料最小揭露：</strong>只回傳必要結果（是／否／等級）。</li>
          <li><strong>驗證不留痕：</strong>避免可識別的持續性驗證軌跡。</li>
          <li><strong>去中心化信任：</strong>以簽章與狀態查核取代集中資料交換。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 六 -->
      <section>
        <h2 id="s6">六、結語：當信任被重新定義</h2>
        <p>
          社福 VC 是起點，讓社會以密碼學取代紙本信任。每一張 VC 都是可被信任、可授權、可撤銷的「信任單位」。當我們不再需要拿著文件到處證明自己，政府與公民的關係也將從審核／被審核，走向基於技術、透明與信任的新契約。
        </p>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post{
  --ink:#222;
  --muted:#6a6a6a;
  --brand:#255081;
  --soft:#f6f9ff;
  --line:#e6eef7;
  line-height:1.85;color:var(--ink);
}
.post h2{font-size:1.12rem;margin:1.1rem 0 .6rem;color:var(--brand);display:inline-flex;gap:.45rem;align-items:center}
.post h2::before{content:"";width:10px;height:10px;border-radius:50%;background:radial-gradient(circle at 40% 40%,#cfe4fa,var(--brand))}
.lead{background:linear-gradient(180deg,#fbfdff,var(--soft));border:1px solid var(--line);border-radius:12px;padding:.9rem 1rem}
.post p{margin:.35rem 0 .8rem}
.tick{margin:.35rem 0 .9rem 1.25rem}
.tick li{list-style:none;position:relative;padding-left:1.2rem;margin:.22rem 0}
.tick li::before{content:"✔";position:absolute;left:0;top:.08rem;color:var(--brand)}
.div{height:1px;background:linear-gradient(90deg,#eef4fb,var(--line) 40%,#eef4fb);border:0;margin:1rem 0}
.grid{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:.8rem;margin-top:.4rem}
.card{background:#fff;border:1px solid var(--line);border-radius:12px;padding:.75rem .9rem}
.card h3{margin:.1rem 0 .35rem;font-size:1rem;color:#1b3d61}
.note{color:var(--muted);font-size:.92rem}

@media (max-width:860px){
  .grid{grid-template-columns:1fr}
  .post h2{font-size:1.06rem}
}
</style>
