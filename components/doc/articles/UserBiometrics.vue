<!-- components/doc/articles/UserBiometrics.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '生物識別（指紋、臉部）在這裡的角色是什麼？真的安全嗎？',
  subtitle: '使用者觀點篇 / 讓「出示憑證」更自然也更安全',
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
        <h2 id="s1">一、生物辨識不是「監控」，而是「開鎖」</h2>
        <p>
          數位憑證 App 的生物辨識<strong>不會上傳任何資料</strong>。其角色不是拿你的臉去比對資料庫，而是
          <em>在你的裝置上</em>解鎖一把鑰匙，就像解鎖手機一樣。
        </p>
      </section>

      <hr class="div" />

      <!-- 二 -->
      <section>
        <h2 id="s2">二、技術核心：本地儲存與安全晶片</h2>
        <ul class="tick">
          <li><strong>Secure Enclave / TrustZone：</strong>生物特徵被鎖在硬體隔離區，App 無權讀取原始樣本。</li>
          <li><strong>回應只有「成功／失敗」：</strong>系統回傳驗證結果，而非你的臉或指紋數據。</li>
          <li><strong>防竄改簽章：</strong>就算 App 被逆向，也無法生成有效憑證簽章。</li>
        </ul>
        <p class="note">結論：App 不知道你的指紋長什麼樣，只知道「是你本人按的」。</p>
      </section>

      <hr class="div" />

      <!-- 三 -->
      <section>
        <h2 id="s3">三、為什麼需要這一層保護？</h2>
        <p>
          在 VC 模型下，<strong>能解鎖的人＝能出示憑證的人</strong>。因此解鎖機制直接關係到你的數位身分安全。生物辨識提供「高安全」與「低阻力」兩者兼得。
        </p>
      </section>

      <hr class="div" />

      <!-- 四 -->
      <section>
        <h2 id="s4">四、為什麼比密碼更安全、更實用？</h2>
        <div class="table-wrap">
          <table class="cmp">
            <thead>
              <tr><th>項目</th><th>密碼</th><th>生物辨識</th></tr>
            </thead>
            <tbody>
              <tr><td>可被猜測／偷看</td><td>高</td><td>極低（不顯示、不傳輸樣本）</td></tr>
              <tr><td>跨服務重複使用風險</td><td>常見</td><td>無（每次均為裝置本地驗證）</td></tr>
              <tr><td>便利性</td><td>易忘、需輸入</td><td>極高（< 0.5s）</td></tr>
              <tr><td>對雲端依賴</td><td>可能需要</td><td>無（本地驗證）</td></tr>
            </tbody>
          </table>
        </div>
      </section>

      <hr class="div" />

      <!-- 五 -->
      <section>
        <h2 id="s5">五、例外情境：手機被偷怎麼辦？</h2>
        <ol class="enum">
          <li><strong>系統層臉／指紋鎖：</strong>非本人難以通過。</li>
          <li><strong>App 次級驗證：</strong>可設定 App PIN／再次確認高風險操作。</li>
          <li><strong>遠端註銷：</strong>可撤銷該裝置上的憑證，使其失效。</li>
        </ol>
        <p>同時滿足「像你、你的指紋、還知道你的 PIN」的攻擊組合幾乎不可行。</p>
      </section>

      <hr class="div" />

      <!-- 六 -->
      <section>
        <h2 id="s6">六、從「被檢查」到「我選擇出示」</h2>
        <p>
          生物辨識的價值不在炫技，而在讓<strong>出示憑證</strong>這件事變得自然與私密：你掃一次臉或按一下指紋，就能安全地出示「已驗證的資格」，而不是攤開個資。
        </p>
      </section>

      <hr class="div" />

      <!-- 七 -->
      <section>
        <h2 id="s7">七、小結：安全與便利並不衝突</h2>
        <ul class="tick">
          <li><strong>方便：</strong>不記密碼、不帶紙本、一秒完成。</li>
          <li><strong>安全：</strong>資料不離機、簽章可驗、授權可控。</li>
        </ul>
        <p class="ending">
          指紋與臉部辨識不是監控者，而是你數位身份的守門人。
        </p>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post{
  --c-ink:#252525;
  --c-muted:#6b665f;
  --c-primary:#315e8a;   /* 穩定藍調 */
  --c-accent:#d3e6f7;
  --c-soft:#f6faff;
  --c-line:#e8f0f8;
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
  background:linear-gradient(180deg,#fbfdff,var(--c-soft));
  border:1px solid #e8f0fb;border-radius:12px;
  padding:.9rem 1rem
}

/* 文本與列表 */
.post p{margin:.35rem 0 .8rem}
.enum{margin:.35rem 0 .9rem 1.25rem}
.enum li{margin:.28rem 0}
.tick{margin:.35rem 0 .9rem 1.25rem}
.tick li{list-style:none;position:relative;padding-left:1.25rem;margin:.22rem 0}
.tick li::before{content:"✔";position:absolute;left:0;top:.1rem;color:var(--c-primary)}

/* 分隔線、表格 */
.div{
  border:0;height:1px;
  background:linear-gradient(90deg,#eef4fb,var(--c-line) 40%,#eef4fb);
  margin:1rem 0 1rem
}
.table-wrap{overflow-x:auto;border:1px solid #e9f1fa;border-radius:12px;background:#fff;margin-top:.35rem}
.cmp{width:100%;min-width:560px;border-collapse:collapse}
.cmp thead th{
  text-align:left;font-weight:700;font-size:.92rem;color:#1d3f63;
  background:#f4f9ff;border-bottom:1px solid var(--c-line);padding:.55rem .7rem
}
.cmp tbody td{padding:.55rem .7rem;border-bottom:1px solid #edf3fb;vertical-align:top}

/* 註記與結語 */
.note{color:var(--c-muted);font-size:.92rem}
.ending{color:#143a5b;font-weight:600}

/* RWD */
@media (max-width:768px){
  .post h2{font-size:1.06rem}
}
</style>
