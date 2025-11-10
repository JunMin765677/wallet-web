<!-- components/doc/articles/UserTrustPrivacy.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '我能相信這個 App 嗎？我的資料真的不會被誰看到嗎？',
  subtitle: '使用者觀點篇 / 把信任交還給使用者的設計',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '使用者觀點篇', to: '/docs#user' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- 一 -->
      <section class="lead">
        <h2 id="s1">一、信任問題，不是「App 相不可信」，而是「我能不能掌控」</h2>
        <p>
          當民眾問「我的資料真的不會被誰看到嗎？」其實是在問：
          <strong>「我能不能自己決定誰看到？」</strong>
        </p>
        <p>
          傳統流程裡，資料一旦交出去便失去掌控。數位憑證的目標，是讓信任重新回到使用者手上。
        </p>
      </section>

      <hr class="div" />

      <!-- 二 -->
      <section>
        <h2 id="s2">二、數位憑證不是「資料庫」，而是一張「加密的證明」</h2>
        <p>你手機裡的 VC 並非完整個資的複製，而是經發證單位簽章的「事實摘要」。</p>
        <div class="table-wrap">
          <table class="cmp">
            <thead>
              <tr><th>項目</th><th>政府原始資料庫</th><th>數位憑證內容</th></tr>
            </thead>
            <tbody>
              <tr><td>年收入</td><td>數值明細</td><td>不存</td></tr>
              <tr><td>身分證字號</td><td>完整字串</td><td>不存</td></tr>
              <tr><td>地址</td><td>完整地址</td><td>不存</td></tr>
              <tr><td>狀態</td><td>是否符合資格</td><td>✅ 符合（已簽章）</td></tr>
            </tbody>
          </table>
        </div>
        <p><em>不是把資料搬進 App，而是把「可信結果」封裝進憑證。</em></p>
      </section>

      <hr class="div" />

      <!-- 三 -->
      <section>
        <h2 id="s3">三、誰能看到？完全由使用者授權</h2>
        <ul class="tick">
          <li>你選哪一張卡：如「身障卡」、「低收入戶卡」。</li>
          <li>你決定給誰：醫院、社工、物資站等。</li>
          <li>你選擇揭露哪些欄位：如只揭露「符合資格」。</li>
        </ul>
        <p>驗證方看見的是「真偽與結果」，而非你的完整個資。</p>
      </section>

      <hr class="div" />

      <!-- 四 -->
      <section>
        <h2 id="s4">四、App 的三重保護機制</h2>
        <ol class="enum">
          <li><strong>本地儲存：</strong>憑證存在你的裝置，不上傳中央伺服器。</li>
          <li><strong>加密封裝：</strong>由政府簽章，任何改動都會驗證失敗。</li>
          <li><strong>即時授權：</strong>出示前清楚顯示授權對象，可中止或刪除。</li>
        </ol>
        <p class="note">備註：目前沙盒多採連線驗證；未來方向支援離線驗證。</p>
      </section>

      <hr class="div" />

      <!-- 五 -->
      <section>
        <h2 id="s5">五、驗證方也不會看到「你沒給的東西」</h2>
        <blockquote class="quote">
          ✅ 是的，我符合票種／補助條件。<br />
          ❌ 但不需要知道我的姓名、住址、身分證號或財稅細節。
        </blockquote>
        <p>透過「選擇性揭露」，甚至可進一步以 ZKP 僅證明「條件成立」。</p>
      </section>

      <hr class="div" />

      <!-- 六 -->
      <section>
        <h2 id="s6">六、「信任」不該是信仰，而是可驗證的機制</h2>
        <ul class="tick">
          <li>驗證方可不連線主資料庫即可檢查簽章真偽。</li>
          <li>發證方簽章公開可查、不可否認。</li>
          <li>憑證生命週期事件可被稽核（不含個資）。</li>
        </ul>
        <p>這是「信任最小化」：不必先相信，也能安全使用。</p>
      </section>

      <hr class="div" />

      <!-- 七 -->
      <section>
        <h2 id="s7">七、那會不會被駭？</h2>
        <ul class="tick">
          <li>就算取得裝置存檔，內容仍為加密封裝，不能竄改。</li>
          <li>沒有發證私鑰無法生成有效憑證。</li>
          <li>你可註銷遺失裝置上的憑證，阻止再次使用。</li>
        </ul>
        <p>設計重點是：<em>就算入侵，也拿不到可用的內容。</em></p>
      </section>

      <hr class="div" />

      <!-- 八 -->
      <section>
        <h2 id="s8">八、小結：信任的基礎不是「保密」，而是「掌控」</h2>
        <p>
          數位憑證讓你不必交出整份資料，只為證明一件事；你也不必「相信伺服器」，因為驗證機制本身即可建立信任。
        </p>
        <p class="ending">
          當信任被設計成機制，答案已內建在系統裡——<br />
          <strong>你才是那個決定誰能看到的人。</strong>
        </p>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post{
  --c-ink:#252525;
  --c-muted:#6b665f;
  --c-primary:#2f6f6d;   /* 穩定的藍綠 */
  --c-accent:#bfe1dd;
  --c-soft:#f6fbfb;
  --c-surface:#fff;
  --c-line:#e6f0ef;
  color:var(--c-ink);
  line-height:1.85;
}

/* 標題與導言 */
.post h2{
  margin:1.1rem 0 .6rem;
  font-size:1.12rem;color:var(--c-primary);
  display:inline-flex;align-items:center;gap:.45rem
}
.post h2::before{
  content:"";width:10px;height:10px;border-radius:50%;
  background:radial-gradient(circle at 40% 40%,var(--c-accent),var(--c-primary));
  display:inline-block
}
.lead{
  background:linear-gradient(180deg,#fbffff,var(--c-soft));
  border:1px solid #e7f2f1;border-radius:12px;
  padding:.9rem 1rem
}

/* 文本與列表 */
.post p{margin:.35rem 0 .8rem}
.enum{margin:.35rem 0 .9rem 1.25rem}
.enum li{margin:.28rem 0}
.tick{margin:.35rem 0 .9rem 1.25rem}
.tick li{list-style:none;position:relative;padding-left:1.25rem;margin:.22rem 0}
.tick li::before{content:"✔";position:absolute;left:0;top:.1rem;color:var(--c-primary)}

/* 引用、分隔 */
.quote{
  background:#fff;border:1px solid #e5f0ef;border-radius:12px;
  padding:.85rem 1rem;color:#1e4c4a;box-shadow:0 2px 6px rgba(0,0,0,.04);margin:.5rem 0
}
.div{
  border:0;height:1px;
  background:linear-gradient(90deg,#eef7f6,var(--c-line) 40%,#eef7f6);
  margin:1rem 0 1rem
}

/* 表格 */
.table-wrap{overflow-x:auto;border:1px solid #e9f3f2;border-radius:12px;background:#fff;margin-top:.35rem}
.cmp{width:100%;min-width:600px;border-collapse:collapse}
.cmp thead th{
  text-align:left;font-weight:700;font-size:.92rem;color:#1e4c4a;
  background:#f3fbfb;border-bottom:1px solid var(--c-line);padding:.55rem .7rem
}
.cmp tbody td{padding:.55rem .7rem;border-bottom:1px solid #eef6f6;vertical-align:top}

/* 註記與結語 */
.note{color:var(--c-muted);font-size:.92rem}
.ending{color:#173f3d;font-weight:600}

/* RWD */
@media (max-width:768px){
  .post h2{font-size:1.06rem}
}
</style>
