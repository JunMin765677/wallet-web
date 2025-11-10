<!-- components/doc/articles/FutureMetricsTrust.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '我們要如何衡量「數位信任」的成效？',
  subtitle: '從上線率到信任率：把技術、行為與社會情緒都量化',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '延伸思考篇', to: '/docs#future' },
  ],
}

// 範例 KPI（可由頁面注入或日後串接 Backend）
const kpis = [
  { label: '簽章驗證成功率', value: '99.92%', desc: 'VC 驗真偽成功比例（近30日）' },
  { label: '撤銷同步延遲', value: '14m', desc: '撤銷狀態傳播平均時間' },
  { label: '紙本替代率', value: '68%', desc: 'VC 取代紙本證明占比' },
  { label: '爭議事件減少率', value: '−37%', desc: '與身份不明／文件過期相關的爭議下降' },
]

const table = [
  { facet: '技術', metric: '簽章驗證成功率', meaning: '系統可信度' },
  { facet: '行為', metric: '驗證頻率 / 紙本替代率', meaning: '實際使用度' },
  { facet: '社會', metric: '信任度調查 / 爭議減少率', meaning: '使用者感受' },
  { facet: '政策', metric: '稽核可追性 / 授權透明度', meaning: '治理成熟度' },
]
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- Hero KPI strip -->
      <section class="kpi-strip" aria-label="信任指標概覽">
        <div v-for="k in kpis" :key="k.label" class="kpi-card" role="group" :aria-label="k.label">
          <div class="kpi-label">{{ k.label }}</div>
          <div class="kpi-value">{{ k.value }}</div>
          <div class="kpi-desc">{{ k.desc }}</div>
        </div>
      </section>

      <section>
        <h2 id="s1">一、從「上線率」到「信任率」：新的衡量思維</h2>
        <p>
          「數位信任」不是流量問題，而是信任關係的建立問題。真正的成功指標不是「多少人下載 App」，而是<strong>有多少人願意相信並用它完成原本會懷疑的事</strong>。
        </p>
        <blockquote class="callout">
          衡量的不只是「用不用」，而是「敢不敢用」與「用得是否安心」。
        </blockquote>
      </section>

      <hr class="div" />

      <section>
        <h2 id="s2">二、技術層：信任是否可被「驗證」</h2>
        <ul class="tick">
          <li><strong>簽章驗證成功率：</strong>VC 被掃描後通過真偽驗證的比例。</li>
          <li><strong>撤銷名單同步延遲：</strong>撤銷／失效更新傳播的平均時間。</li>
          <li><strong>離線驗證比率：</strong>網路不穩仍可完成驗證的次數（可列為中長期目標）。</li>
          <li><strong>可審計事件覆蓋率：</strong>簽發、驗證、授權是否皆有完整可追蹤紀錄。</li>
        </ul>
        <p class="muted">
          重點：讓系統「自證無需被信」，以可驗證性取代喊口號。
        </p>
      </section>

      <hr class="div" />

      <section>
        <h2 id="s3">三、行為層：信任是否「被使用」</h2>
        <ul class="tick">
          <li><strong>驗證頻率（Verification Frequency）：</strong>憑證實際被出示與驗證的次數。</li>
          <li><strong>驗證成功率：</strong>出示後可通過驗證的比例。</li>
          <li><strong>重複使用率：</strong>同一使用者跨場域（醫院／慈善／學校）使用 VC 的次數。</li>
          <li><strong>人工補件減少率：</strong>導入 VC 後仍需補件的比例是否下降。</li>
          <li><strong>紙本替代率：</strong>被 VC 取代的紙本證明數量或占比。</li>
        </ul>
        <blockquote class="callout">
          行為資料應匿名聚合，觀測「流程是否更順」，而非「誰在用」。
        </blockquote>
      </section>

      <hr class="div" />

      <section>
        <h2 id="s4">四、社會層：信任是否「被感受」</h2>
        <ol class="steps">
          <li><strong>民眾信任度調查：</strong>「我相信我的資料在此系統中是安全的」之認同比例。</li>
          <li><strong>驗證單位信任度：</strong>醫院、慈善機構、里辦對 VC 結果的信任程度。</li>
          <li><strong>爭議事件減少率：</strong>因身份不明、資料不符、文件過期導致的誤拒／延誤案件數。</li>
        </ol>
        <p class="muted">用質化訪談補強量化數據，追蹤「安心感」是否提升。</p>
      </section>

      <hr class="div" />

      <section>
        <h2 id="s5">五、政策層：信任能否「持續維運」</h2>
        <ul class="tick">
          <li><strong>系統透明度：</strong>是否公開 VC 規格、簽章方式、授權名單與版本歷程。</li>
          <li><strong>稽核可追性：</strong>是否能追蹤每一筆驗證的技術軌跡（不含個資）。</li>
          <li><strong>濫用防範紀錄：</strong>年度撤銷授權或遭通報之機構數量與處置時效。</li>
          <li><strong>知情權與刪除權落實度：</strong>民眾能否查「誰驗過我」、能否刪除憑證。</li>
        </ul>
      </section>

      <hr class="div" />

      <section>
        <h2 id="s6">六、建立「信任儀表板」的概念</h2>
        <p>
          以 <em>Trust Dashboard</em> 將四個面向匯聚：技術（可驗證性）、行為（使用度）、社會（感受度）、政策（治理度）。下表為最小可行欄位：
        </p>
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th>面向</th>
                <th>指標</th>
                <th>意義</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="row in table" :key="row.facet">
                <td>{{ row.facet }}</td>
                <td>{{ row.metric }}</td>
                <td>{{ row.meaning }}</td>
              </tr>
            </tbody>
          </table>
        </div>
        <ul class="notes">
          <li>指標須<strong>匿名化與聚合</strong>呈現，避免形成新型監控。</li>
          <li>每季檢視「短板指標」，以迭代優先順序推動改善。</li>
        </ul>
      </section>

      <hr class="div" />

      <section>
        <h2 id="s7">七、結語：信任不是 KPI，而是公共基礎建設</h2>
        <p>
          衡量的目的不是比數字，而是確保這條路能長久走下去。最理想的狀態是——<strong>即使不必相信，系統依然安全運作</strong>：因為每一步都有簽章、邊界、與可被檢驗的證據。
        </p>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post{--ink:#1b1f23;--muted:#6b7280;--brand:#1e4872;--soft:#f6fbff;--line:#e6eef6;--card:#ffffff;line-height:1.85;color:var(--ink)}
h2{font-size:1.12rem;margin:1rem 0 .6rem;color:var(--brand)}
.muted{color:var(--muted)}
.callout{margin:.6rem 0;padding:.65rem .8rem;background:var(--soft);border:1px solid var(--line);border-radius:10px}
.div{height:1px;border:0;margin:1rem 0;background:linear-gradient(90deg,#f2f7fc,var(--line) 40%,#f2f7fc)}
.tick{margin:.4rem 0 .9rem 1.25rem}
.tick li{list-style:none;position:relative;padding-left:1.15rem;margin:.28rem 0}
.tick li::before{content:"✔";position:absolute;left:0;top:.08rem;color:var(--brand)}
.steps{margin:.5rem 0 .9rem 1.2rem}
.steps li{margin:.35rem 0}
.notes{margin:.5rem 0 .2rem 1.1rem}
.notes li{list-style:disc;margin:.25rem 0}
.table-wrap{overflow:auto;border:1px solid var(--line);border-radius:12px}
table{width:100%;border-collapse:collapse;font-size:.95rem}
thead th{background:#f6f9ff;text-align:left;padding:.6rem .7rem;border-bottom:1px solid var(--line);white-space:nowrap}
tbody td{padding:.55rem .7rem;border-top:1px solid var(--line)}
/* KPI strip */
.kpi-strip{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:.8rem;margin:.2rem 0 1rem}
.kpi-card{background:var(--card);border:1px solid var(--line);border-radius:14px;padding:.8rem .9rem}
.kpi-label{font-size:.8rem;color:var(--muted)}
.kpi-value{font-size:1.35rem;font-weight:700;margin:.25rem 0 .15rem}
.kpi-desc{font-size:.8rem;color:var(--muted)}
@media (max-width:980px){.kpi-strip{grid-template-columns:repeat(2,minmax(0,1fr))}}
@media (max-width:620px){.kpi-strip{grid-template-columns:1fr}}
</style>
