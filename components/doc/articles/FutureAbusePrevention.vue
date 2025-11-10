<!-- components/doc/articles/FutureAbusePrevention.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '若公部門開放 VC 架構給醫院、慈善團體或學校，該如何防止濫用？',
  subtitle: '開放不是放任，而是讓信任有邊界',
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
        <h2 id="s1">一、開放與濫用之間，只差一層「授權設計」</h2>
        <p>
          開放 VC（可驗證憑證）給外部機構，開放的是<strong>驗證能力</strong>而非<strong>資料本身</strong>。關鍵在於「誰能用、用到哪裡為止」，而不是能不能用。
        </p>
        <blockquote class="callout">
          VC 的本質：讓驗證走出去，讓資料留在原地。
        </blockquote>
      </section>

      <hr class="div" />

      <!-- 二 -->
      <section>
        <h2 id="s2">二、「可驗證」不代表「可任意驗證」</h2>
        <p>
          VC 遵循<strong>最小揭露（Minimal Disclosure）</strong>與<strong>主動授權</strong>原則：驗證方只能看到使用者同意揭露的必要資訊，且每次驗證都需有明確目的（Purpose Binding）。
        </p>
        <ul class="tick">
          <li>醫院可查「是否具低收入戶資格」，不可見收入明細。</li>
          <li>App 以清楚提示顯示驗證方與用途，使用者點選同意後才進行。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 三 -->
      <section>
        <h2 id="s3">三、授權與撤銷機制：讓權限可給也可收回</h2>
        <div class="grid">
          <div class="card">
            <h3>授權清單（Verification Registry）</h3>
            <ul>
              <li>列管所有被允許的驗證單位（Verifier DID）。</li>
              <li>註記驗證範圍與使用目的（醫療／教育／公益）。</li>
              <li>名單公開透明，供民眾查詢。</li>
            </ul>
          </div>
          <div class="card">
            <h3>憑證／權限撤銷（Revocation）</h3>
            <ul>
              <li>違規即時撤銷驗證權限，同步到信任清單。</li>
              <li>發證端金鑰洩漏可撤銷並重建信任鏈。</li>
            </ul>
          </div>
          <div class="card">
            <h3>限時授權</h3>
            <ul>
              <li>每筆授權設定有效期限（如 6 個月）。</li>
              <li>到期需重審與再授權。</li>
            </ul>
          </div>
        </div>
      </section>

      <hr class="div" />

      <!-- 四 -->
      <section>
        <h2 id="s4">四、如何避免「目的外使用」？</h2>
        <ol class="steps">
          <li>
            <strong>目的碼綁定（purpose_code）</strong>：每個驗證請求皆需附上唯一用途碼（如 MED01、EDU02、NGO03），伺服器留痕時間戳記以供稽核。
          </li>
          <li>
            <strong>匿名化統計回報</strong>：驗證方定期回報不含個資的統計（次數／目的／成功率），政府得以掌握趨勢而不蒐集個資。
          </li>
        </ol>
      </section>

      <hr class="div" />

      <!-- 五 -->
      <section>
        <h2 id="s5">五、資料不集中，也能共同防弊</h2>
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th>比較項目</th>
                <th>傳統集中式系統</th>
                <th>VC 分散式架構</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>資料存放</td>
                <td>中央伺服器</td>
                <td>使用者裝置</td>
              </tr>
              <tr>
                <td>驗證方式</td>
                <td>系統查資料</td>
                <td>驗簽章比對</td>
              </tr>
              <tr>
                <td>防弊方式</td>
                <td>內部稽核</td>
                <td>可追蹤簽章、撤銷授權</td>
              </tr>
              <tr>
                <td>風險點</td>
                <td>集中外洩</td>
                <td>單點無效、整體安全</td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>

      <hr class="div" />

      <!-- 六 -->
      <section>
        <h2 id="s6">六、倫理與社會面：信任要有「回報機制」</h2>
        <ul class="tick">
          <li>出示後即顯示「你剛在何處被驗證」。</li>
          <li>提供民眾對驗證單位的信任評分與舉報通道。</li>
          <li>異常驗證行為自動告警與通報。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 七 -->
      <section>
        <h2 id="s7">七、結語：開放不是放任，而是「讓信任有邊界」</h2>
        <p>
          開放 VC 的目的，是在既定邊界內讓授權機構安全使用信任能力：<strong>透明、可稽核、可回收</strong>。唯有如此，醫院、慈善團體、學校才能在不觸碰隱私的前提下，共同推動公共服務的數位化。
        </p>
        <blockquote class="callout">
          真正的開放，是把控制權設計成機制，而非口號。
        </blockquote>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post{--ink:#1b1f23;--muted:#6b7280;--brand:#1e4872;--soft:#f6fbff;--line:#e6eef6;line-height:1.85;color:var(--ink)}
h2{font-size:1.12rem;margin:1rem 0 .6rem;color:var(--brand)}
.callout{margin:.6rem 0;padding:.65rem .8rem;background:var(--soft);border:1px solid var(--line);border-radius:10px}
.tick{margin:.4rem 0 .9rem 1.25rem}
.tick li{list-style:none;position:relative;padding-left:1.1rem;margin:.22rem 0}
.tick li::before{content:"✔";position:absolute;left:0;top:.08rem;color:var(--brand)}
.steps{margin:.4rem 0 .9rem 1.2rem}
.steps li{margin:.35rem 0}
.div{height:1px;border:0;margin:1rem 0;background:linear-gradient(90deg,#f2f7fc,var(--line) 40%,#f2f7fc)}
.grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:.8rem}
.card{background:#fff;border:1px solid var(--line);border-radius:12px;padding:.75rem .9rem}
.card h3{margin:.1rem 0 .35rem;font-size:1rem;color:#173a5c}
.table-wrap{overflow:auto;border:1px solid var(--line);border-radius:12px}
table{width:100%;border-collapse:collapse;font-size:.95rem}
thead th{background:#f6f9ff;text-align:left;padding:.6rem .7rem;border-bottom:1px solid var(--line);white-space:nowrap}
tbody td{padding:.55rem .7rem;border-top:1px solid var(--line)}
@media (max-width:980px){.grid{grid-template-columns:1fr}}
</style>
