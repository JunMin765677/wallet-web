<!-- components/doc/articles/FuturePublicPrivate.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '政府與民間如何共享這套驗證機制？',
  subtitle: '共享的不是資料，而是信任本身',
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
      <section>
        <h2 id="s1">一、從「權責分工」到「信任共用」</h2>
        <p>
          傳統政府資訊系統強調權限與責任，但也造成跨局處服務不連貫。VC（可驗證憑證）提供的不是「資料共用」，而是「信任共用」：不必開放資料庫，只需共享<strong>誰能發證、誰能驗證</strong>的信任關係。
        </p>
        <blockquote class="callout">
          VC 不是打開資料庫，而是把「驗證真偽」的能力安全地交出去。
        </blockquote>
      </section>

      <hr class="div" />

      <!-- 二 -->
      <section>
        <h2 id="s2">二、信任清單（Trust Registry）：共用的核心</h2>
        <p>
          政府建立公開透明的<strong>信任清單</strong>，記錄發證者、驗證者、憑證類型與適用範圍，以及憑證標準（VC schema）。民間機構對照清單驗簽，不需連政府主資料庫。
        </p>
        <ul class="tick">
          <li>列出可簽發單位（Issuer）與可驗證單位（Verifier）。</li>
          <li>標示各單位可處理之憑證類型與範圍。</li>
          <li>公開對應之憑證結構與版本。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 三 -->
      <section>
        <h2 id="s3">三、共享機制的三個層次</h2>
        <ol class="steps">
          <li>
            <strong>技術層：共用簽章機制，而非共用資料</strong><br />
            以 PKI 或 DID 發佈簽章；驗證方只需核對簽章與信任清單，即可確認真偽。
            <span class="note">→ 驗證一致性，不產生資料連結性。</span>
          </li>
          <li>
            <strong>治理層：共用規則，而非共用權限</strong><br />
            建立簽發與驗證授權制度；中央定規範，地方與民間依規運作，責任清楚。
          </li>
          <li>
            <strong>應用層：共用介面，而非共用平台</strong><br />
            以 API／SDK 供各自系統嵌入，不必登入政府端平台，形成「多節點、共信任」生態。
          </li>
        </ol>
      </section>

      <hr class="div" />

      <!-- 四 -->
      <section>
        <h2 id="s4">四、共享帶來的潛在價值</h2>
        <ul class="tick">
          <li><strong>服務走出去：</strong>民眾在醫院、學校、慈善機構等民間場域亦能安全驗證。</li>
          <li><strong>民間長出公共信任：</strong>引用政府簽章，發展弱勢優惠、公益補助等服務。</li>
          <li><strong>數據流動不外洩：</strong>以事件統計了解趨勢，無需收集個資。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 五 -->
      <section>
        <h2 id="s5">五、挑戰：信任能共享，但濫用不能擴散</h2>
        <div class="grid">
          <div class="card">
            <h3>信任門檻</h3>
            <ul>
              <li>驗證者需登錄與簽署使用規範。</li>
              <li>說明用途、留存政策與服務對象。</li>
              <li>保留撤銷驗證權限能力。</li>
            </ul>
          </div>
          <div class="card">
            <h3>稽核機制</h3>
            <ul>
              <li>簽章與驗證事件留痕（不含個資）。</li>
              <li>獨立單位定期審查正當性。</li>
            </ul>
          </div>
          <div class="card">
            <h3>透明原則</h3>
            <ul>
              <li>授權單位公開於信任清單。</li>
              <li>民眾可查「誰驗過我的憑證」。</li>
            </ul>
          </div>
        </div>
      </section>

      <hr class="div" />

      <!-- 六 -->
      <section>
        <h2 id="s6">六、範例：政府 × 民間的共用場景</h2>
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th>場景</th>
                <th>發證者</th>
                <th>驗證者</th>
                <th>數位憑證應用</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>社福補助申請</td>
                <td>社會局</td>
                <td>里辦公處／慈善機構</td>
                <td>驗證民眾社福資格</td>
              </tr>
              <tr>
                <td>公共醫療補助</td>
                <td>衛福部</td>
                <td>醫院</td>
                <td>驗證身障或低收入資格</td>
              </tr>
              <tr>
                <td>教育補助</td>
                <td>教育部</td>
                <td>學校／補習班</td>
                <td>驗證學籍或家庭收入</td>
              </tr>
              <tr>
                <td>公益服務</td>
                <td>社政單位</td>
                <td>NGO／企業</td>
                <td>驗證志工身份或參與紀錄</td>
              </tr>
              <tr>
                <td>青年租屋補助</td>
                <td>內政部</td>
                <td>房東／租屋平台</td>
                <td>驗證資格與合約真偽</td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>

      <hr class="div" />

      <!-- 七 -->
      <section>
        <h2 id="s7">七、結語：共享的不是資料，而是信任本身</h2>
        <p>
          公私協力的目標不是建立「更大的資料庫」，而是打造「誰都能驗、誰也不能偷看」的公共基礎。共享信任不等於放棄保護；真正的合作，應由<strong>交換資料</strong>走向<strong>交換信任</strong>。
        </p>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post{--ink:#1c1c1c;--muted:#6b7280;--brand:#1f4e7a;--soft:#f7fbff;--line:#e8eef6;line-height:1.85;color:var(--ink)}
h2{font-size:1.12rem;margin:1rem 0 .6rem;color:var(--brand)}
.callout{margin:.6rem 0;padding:.6rem .8rem;background:var(--soft);border:1px solid var(--line);border-radius:10px}
.tick{margin:.4rem 0 .9rem 1.25rem}
.tick li{list-style:none;position:relative;padding-left:1.1rem;margin:.22rem 0}
.tick li::before{content:"✔";position:absolute;left:0;top:.08rem;color:var(--brand)}
.steps{margin:.4rem 0 .9rem 1.2rem}
.steps li{margin:.35rem 0}
.note{color:var(--muted);margin-left:.25rem}
.div{height:1px;border:0;margin:1rem 0;background:linear-gradient(90deg,#f1f6fc,var(--line) 40%,#f1f6fc)}
.grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:.8rem}
.card{background:#fff;border:1px solid var(--line);border-radius:12px;padding:.75rem .9rem}
.card h3{margin:.1rem 0 .35rem;font-size:1rem;color:#173a5c}
.table-wrap{overflow:auto;border:1px solid var(--line);border-radius:12px}
table{width:100%;border-collapse:collapse;font-size:.95rem}
thead th{background:#f6f9ff;text-align:left;padding:.6rem .7rem;border-bottom:1px solid var(--line);white-space:nowrap}
tbody td{padding:.55rem .7rem;border-top:1px solid var(--line)}
@media (max-width:980px){.grid{grid-template-columns:1fr}}
</style>
