<!-- components/doc/articles/UserAccessibility.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '如果我是長輩或行動不便者，這個 App 會讓我更方便還是更困難？',
  subtitle: '使用者觀點篇 / 從可及性出發：少操作、多被幫助',
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
        <h2 id="s1">一、這個問題的關鍵在「誰主動」</h2>
        <p>很多人聽到「數位 App」就會直覺想到：</p>
        <blockquote class="quote">「長輩又不會用手機，這東西他們用得到嗎？」</blockquote>
        <p>
          這個問題非常真實。台灣有許多高齡者、行動不便者、或長照家庭，他們的日常已被繁瑣的文件、證明與奔波耗盡。任何「新科技」若只是讓事情更複雜，那就不是進步。
        </p>
        <p>
          數位憑證要對這群人有幫助，關鍵不是「讓他們學會用」，而是
          <strong>讓他們不需要學會也能受惠。</strong>
        </p>
      </section>

      <hr class="div" />

      <!-- 二 -->
      <section>
        <h2 id="s2">二、現實困境：長輩不是不願意，而是「太多關卡」</h2>
        <blockquote class="quote small">
          「我已經不知道上次那個證明放哪去了。」<br />
          「每次都要去公所排隊，太遠了我走不動。」<br />
          「我手機裡那個東西，我不敢亂按，怕弄壞。」
        </blockquote>
        <p>
          對許多長輩而言，「數位」不是恐懼，而是不確定感——怕錯、怕被罵、怕弄壞。因此設計重點不在「教會操作」，而是
          <strong>減少必須操作的步驟。</strong>
        </p>
      </section>

      <hr class="div" />

      <!-- 三 -->
      <section>
        <h2 id="s3">三、解法一：讓「出示」比「操作」簡單</h2>
        <ul class="tick">
          <li>首頁即「出示我的憑證」的單一主動作。</li>
          <li>一鍵顯示 QR Code，無需在多層選單搜尋。</li>
          <li>支援「常用卡片」桌面捷徑，由家人預先設定。</li>
        </ul>
        <p>比起帶一疊紙本，這樣更簡單、更不易遺失。</p>
      </section>

      <hr class="div" />

      <!-- 四 -->
      <section>
        <h2 id="s4">四、解法二：讓「他人代為協助」成為制度的一部分</h2>
        <p>
          現實裡大量需求來自「家屬／社工／里幹事代辦」。以數位憑證將其正規化為
          <strong>授權式</strong>流程：
        </p>
        <ol class="enum">
          <li>於 App 設定「授權代理人」。</li>
          <li>代理人出示時，系統明確標示「經本人授權」。</li>
          <li>驗證端僅確認真偽與授權，不需登入資料庫。</li>
        </ol>
        <p>代辦從灰色地帶變成可查驗、可追溯的信任機制。</p>
      </section>

      <hr class="div" />

      <!-- 五 -->
      <section>
        <h2 id="s5">五、解法三：讓「現場驗證」取代「事前準備」</h2>
        <p>
          傳統流程要先備齊戶籍謄本、證明、影本；數位憑證改為
          <strong>現場即時驗證</strong>：
        </p>
        <blockquote class="quote">出示 QR Code → 驗證端即時比對 → 顯示「資格有效／無效」</blockquote>
        <p>不必記有效期、不必反覆奔波；過期由 App 主動提醒與引導續辦。</p>
      </section>

      <hr class="div" />

      <!-- 六 -->
      <section>
        <h2 id="s6">六、解法四：讓「手機不再是唯一入口」</h2>
        <div class="table-wrap">
          <table class="cmp">
            <thead>
              <tr>
                <th>入口</th>
                <th>適用情境</th>
                <th>備註</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>實體 QR 卡</td>
                <td>無智慧型手機者</td>
                <td>社福單位代印，承載相同簽章資料</td>
              </tr>
              <tr>
                <td>服務據點協助</td>
                <td>里辦／長照機構</td>
                <td>由櫃檯協助開啟驗證流程</td>
              </tr>
              <tr>
                <td>家屬遠端管理</td>
                <td>照護者協助</td>
                <td>以授權身分協助更新／續期</td>
              </tr>
            </tbody>
          </table>
        </div>
        <p>「有手機用 App、沒手機用卡片」——不讓任何人被排除。</p>
      </section>

      <hr class="div" />

      <!-- 七 -->
      <section>
        <h2 id="s7">七、解法五：介面與文字設計的溫度</h2>
        <ul class="tick">
          <li>按鈕大、選項少；主要動作置頂且固定。</li>
          <li>每一步都有回饋（如：✅ 已顯示、📱 已出示）。</li>
          <li>錯誤以自然語言呈現（例：「網路不穩定，請稍後再試」）。</li>
          <li>高對比、可調字級、語音朗讀與讀屏友善。</li>
        </ul>
      </section>

      <hr class="div" />

      <!-- 八 -->
      <section>
        <h2 id="s8">八、結語：讓「便利」不只屬於熟悉科技的人</h2>
        <p>
          數位轉型的目的不是讓懂技術的人更便利，而是讓本來不方便的人
          <strong>少受一點折騰</strong>。
        </p>
        <p class="ending">
          對長輩與行動不便者而言，數位憑證的價值不在「掃碼多快」，而在於：<br />
          <em>不用再為了拿一張紙，走一整天的路。</em><br />
          當技術願意往弱勢那一端多靠近一步，它就不只是系統升級，而是社會進步。
        </p>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post{
  --c-ink:#262626;
  --c-muted:#6b665f;
  --c-primary:#6e7f2a;   /* 穩重、友善的綠 */
  --c-accent:#c7d49b;
  --c-soft:#fbfdf5;
  --c-surface:#fff;
  --c-line:#e6ecd4;
  color:var(--c-ink);
  line-height:1.8;
}

/* 標題、導言 */
.post h2{
  margin:1.12rem 0 .55rem;
  font-size:1.12rem;color:var(--c-primary);
  display:inline-flex;align-items:center;gap:.45rem
}
.post h2::before{
  content:"";width:10px;height:10px;border-radius:50%;
  background:radial-gradient(circle at 40% 40%,var(--c-accent),var(--c-primary));
  display:inline-block
}
.lead{
  background:linear-gradient(180deg,#fefffb,var(--c-soft));
  border:1px solid #ecf2da;border-radius:12px;
  padding:.9rem 1rem
}

/* 文字與列表 */
.post p{margin:.35rem 0 .75rem}
.enum{margin:.35rem 0 .9rem 1.25rem}
.enum li{margin:.28rem 0}
.tick{margin:.35rem 0 .9rem 1.25rem}
.tick li{list-style:none;position:relative;padding-left:1.25rem;margin:.22rem 0}
.tick li::before{content:"✔";position:absolute;left:0;top:.1rem;color:var(--c-primary)}

/* 引用、分隔 */
.quote{
  background:#fff;border:1px solid #e9efda;border-radius:12px;
  padding:.85rem 1rem;color:#3a4a1a;box-shadow:0 2px 6px rgba(0,0,0,.04);margin:.45rem 0
}
.quote.small{font-size:.95rem;line-height:1.7}
.div{
  border:0;height:1px;
  background:linear-gradient(90deg,#eef3dd,var(--c-line) 40%,#eef3dd);
  margin:1rem 0 1rem
}

/* 表格 */
.table-wrap{overflow-x:auto;border:1px solid #eaf0de;border-radius:12px;background:#fff;margin-top:.35rem}
.cmp{width:100%;min-width:640px;border-collapse:collapse}
.cmp thead th{
  text-align:left;font-weight:700;font-size:.92rem;color:#4a5a1d;
  background:#f7fbec;border-bottom:1px solid var(--c-line);padding:.55rem .7rem
}
.cmp tbody td{padding:.55rem .7rem;border-bottom:1px solid #eef4e2;vertical-align:top}

/* 結語 */
.ending{color:#2f3d11;font-weight:600}

/* RWD */
@media (max-width:768px){
  .post h2{font-size:1.06rem}
}
</style>
