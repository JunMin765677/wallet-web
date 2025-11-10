<!-- components/doc/articles/FutureVisibilityEthics.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '什麼樣的數據應該「被看見」，什麼又應該「永遠被隱藏」？',
  subtitle: '在透明與隱私之間劃出可操作的邊界',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '延伸思考篇', to: '/docs#future' },
  ],
}

const seeItems = [
  {
    title: '制度層的運作數據',
    bullets: [
      '發證／驗證單位、授權名單（Trust Registry）',
      '憑證簽章規格、演算法版本與信任清單',
      '匿名化的驗證事件趨勢（僅統計）',
    ],
  },
  {
    title: '使用行為的總量統計（匿名化）',
    bullets: [
      '驗證次數、地區分布、時段波動',
      '紙本替代比例與人工補件變化',
    ],
  },
  {
    title: '治理與稽核紀錄',
    bullets: [
      '濫用通報與處置、授權撤銷事件',
      '異常稽核結果與修正進度',
    ],
  },
]

const hideItems = [
  '姓名、身分證字號、生日、地址、照片等識別資料',
  '親屬姓名、戶籍連結、監護與撫養關係等家庭關聯',
  '收入、資產、稅務明細等經濟狀況',
  '疾病、身障等級、就診紀錄等醫療與身心狀態',
  '低收／中低收、補助等級等社會福利狀態',
]

const principles = [
  { k: '可查但不可識別', v: '對外公開統計與機制，剝離個體識別。' },
  { k: '可授權但不可默許', v: '每次使用需明示目的與同意，不得默認。' },
  { k: '可追蹤但不可監控', v: '保留技術事件鏈，禁止形成行為軌跡。' },
  { k: '可撤銷但不可永久綁定', v: '憑證與授權可撤回，落實被遺忘權。' },
]
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- Intro -->
      <section>
        <p>
          數位憑證（VC）帶來「可驗證性」與「最小揭露性」，也迫使我們回答兩個關鍵問題：<strong>哪些數據應公開，以建立社會信任？哪些數據即使技術進步也不該被看見？</strong>
        </p>
        <blockquote class="hero">
          透明不等於曝光；真正該被看見的，是權力與制度的運作，而不是個人的脆弱。
        </blockquote>
      </section>

      <hr class="div" />

      <!-- See vs Hide -->
      <section>
        <h2 id="see">二、該被「看見」的，是系統，而不是個人</h2>
        <div class="grid">
          <div v-for="item in seeItems" :key="item.title" class="card">
            <h3 class="card-title">{{ item.title }}</h3>
            <ul class="tick">
              <li v-for="b in item.bullets" :key="b">{{ b }}</li>
            </ul>
          </div>
        </div>
        <p class="muted tip">
          問題轉譯：<em>「這套機制怎麼運作？誰有權驗？誰在用？」</em>——公開答案，但不公開個人。
        </p>
      </section>

      <section>
        <h2 id="hide">三、該被「隱藏」的，是任何可連結到個人的資訊</h2>
        <div class="danger-box" role="note" aria-label="永遠不可公開的資料類型">
          <ul class="cross">
            <li v-for="h in hideItems" :key="h">{{ h }}</li>
          </ul>
          <p class="muted">即使出於公務，「脫離原目的」的再利用皆需重新授權。</p>
        </div>
      </section>

      <hr class="div" />

      <!-- Anonymization caveat -->
      <section>
        <h2 id="anon">四、「匿名化」不是萬靈丹</h2>
        <p>
          在巨量資料下，少數欄位即可重識別。防護重點應從「匿名化」進一步走向
          <strong>去連結化（De-linking）</strong>與<strong>最小揭露（Minimal Disclosure）</strong>：
        </p>
        <ul class="dot">
          <li>預設不保存可交叉比對的欄位，降低關聯風險。</li>
          <li>驗證端僅取得「結果」而非「原因」（例：<em>符合</em>而非完整明細）。</li>
          <li>事件紀錄只保留技術簽章與指紋，不留個資內容。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- Human dignity -->
      <section>
        <h2 id="dignity">五、「永遠被隱藏」的，不只是資料，還有人們的脆弱</h2>
        <p>
          每一筆社福資料都是生活處境的切片。系統設計應讓「需求被理解」，不讓「身份被看穿」：社工知道
          <em>有資格</em>，醫療知道<em>享補助</em>，但無需看見背後細節。
        </p>
        <blockquote class="callout">
          讓服務到位，而不是讓人被看見。
        </blockquote>
      </section>

      <hr class="div" />

      <!-- Principles -->
      <section>
        <h2 id="principles">六、設計原則：讓「看見」成為權利，而不是風險</h2>
        <div class="principles">
          <div v-for="p in principles" :key="p.k" class="p-card">
            <div class="p-k">{{ p.k }}</div>
            <div class="p-v">{{ p.v }}</div>
          </div>
        </div>
      </section>

      <hr class="div" />

      <!-- Closing -->
      <section>
        <h2 id="close">七、結語：讓資料服務人，而不是審判人</h2>
        <p>
          數位憑證的價值在於：<strong>政府少知道一些，也能提供服務；社會更透明一些，卻不傷害個人</strong>。當「制度的誠實」被看見，而「人的脆弱」被保護，數位信任才能真正落地。
        </p>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post{--ink:#1b1f23;--muted:#6b7280;--brand:#1e4872;--soft:#f6fbff;--line:#e6eef6;--card:#fff;--warn:#fff4f4;--warnline:#ffd9d9;color:var(--ink);line-height:1.85}
h2{font-size:1.12rem;margin:1rem 0 .6rem;color:var(--brand)}
h3{font-size:1rem;margin:.4rem 0 .3rem}
.muted{color:var(--muted)}
.hero{margin:.7rem 0;padding:.8rem 1rem;background:var(--soft);border:1px solid var(--line);border-radius:12px}
.callout{margin:.6rem 0;padding:.65rem .8rem;background:#f8fff6;border:1px solid #e1f2da;border-radius:12px}
.div{height:1px;border:0;margin:1rem 0;background:linear-gradient(90deg,#f2f7fc,var(--line) 40%,#f2f7fc)}
.grid{display:grid;gap:.9rem;grid-template-columns:repeat(3,minmax(0,1fr))}
.card{background:var(--card);border:1px solid var(--line);border-radius:14px;padding:.8rem .9rem}
.card-title{font-weight:700}
.tick{margin:.4rem 0 .2rem 1.1rem}
.tick li{list-style:none;position:relative;padding-left:1.05rem;margin:.24rem 0}
.tick li::before{content:"✔";position:absolute;left:0;top:.05rem;color:var(--brand)}
.cross{margin:.2rem 0 .2rem 1.1rem}
.cross li{list-style:none;position:relative;padding-left:1.05rem;margin:.22rem 0}
.cross li::before{content:"✖";position:absolute;left:0;top:.05rem;color:#c24141}
.dot{margin:.4rem 0 .2rem 1.1rem}
.dot li{list-style:disc;margin:.26rem 0}
.danger-box{margin:.5rem 0;padding:.85rem 1rem;background:var(--warn);border:1px solid var(--warnline);border-radius:14px}
.tip{margin-top:.45rem}
.principles{display:grid;gap:.8rem;grid-template-columns:repeat(4,minmax(0,1fr))}
.p-card{border:1px solid var(--line);border-radius:12px;padding:.7rem .85rem;background:var(--card)}
.p-k{font-weight:800;margin-bottom:.2rem}
.p-v{color:var(--muted)}
@media (max-width:1024px){.grid{grid-template-columns:repeat(2,minmax(0,1fr))}.principles{grid-template-columns:repeat(2,minmax(0,1fr))}}
@media (max-width:640px){.grid{grid-template-columns:1fr}.principles{grid-template-columns:1fr}}
</style>
