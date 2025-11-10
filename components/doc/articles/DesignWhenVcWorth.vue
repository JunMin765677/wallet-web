<!-- components/doc/articles/DesignWhenVcWorth.vue -->
<script setup lang="ts">
import ArticleFrame from '~/components/doc/ArticleFrame.vue'

const meta = {
  title: '折價券、票券、房卡這些也要用 VC 嗎？什麼情境才「值得」？',
  subtitle: '設計理念篇 / 場景取捨 × 風險權衡 × 慎用原則',
  breadcrumb: [
    { label: '文件中心', to: '/docs' },
    { label: '設計理念篇', to: '/docs#philo' },
  ],
}
</script>

<template>
  <ArticleFrame :title="meta.title" :subtitle="meta.subtitle" :breadcrumb="meta.breadcrumb">
    <article class="post">
      <!-- 一、不是每件事都需要 VC -->
      <section class="lead">
        <h2 id="s1">一、不是每件事都需要 VC</h2>
        <p>
          在技術論壇或競賽中，VC 常被視為萬用通行證：「票券做 VC、會員卡上鏈、折價券可驗偽」。
          但現實世界裡，<strong>能做不等於該做</strong>。VC 是一種信任架構，不是行銷素材；
          重點在於當真實世界需要被信任時，信任可以被驗證、但不被濫用。
        </p>
      </section>

      <hr class="div" />

      <!-- 二、關鍵判斷 -->
      <section>
        <h2 id="s2">二、關鍵判斷：這個「資格」是否牽涉信任與風險？</h2>
        <p>
          VC 需要發行者、簽章、公鑰管理與驗證端的建置；若偽造不會造成重大損失，投入便不合理。
          可用下表快速判斷：
        </p>

        <div class="table-wrap">
          <table class="cmp">
            <thead>
              <tr>
                <th scope="col">憑證類型</th>
                <th scope="col">核心需求</th>
                <th scope="col">偽造風險</th>
                <th scope="col">涉及個資</th>
                <th scope="col">是否值得用 VC？</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row">折價券 / 集點卡</th>
                <td>行銷推廣</td>
                <td>低</td>
                <td>否</td>
                <td><span class="badge bad">✗ 不值得</span></td>
              </tr>
              <tr>
                <th scope="row">活動入場票 / 展覽票</th>
                <td>有限度身分核對</td>
                <td>中</td>
                <td>否</td>
                <td><span class="badge maybe">△ 視規模而定</span></td>
              </tr>
              <tr>
                <th scope="row">旅館房卡</th>
                <td>即時授權、有效期限</td>
                <td>中</td>
                <td>否</td>
                <td><span class="badge maybe">△ 跨系統整合可考慮</span></td>
              </tr>
              <tr>
                <th scope="row">學生證 / 畢業證書</th>
                <td>長期身分與權限</td>
                <td>高</td>
                <td>是</td>
                <td><span class="badge good">✓ 值得</span></td>
              </tr>
              <tr>
                <th scope="row">身障證明 / 福利卡</th>
                <td>涉及補助與社會資源</td>
                <td>高</td>
                <td>是</td>
                <td><span class="badge good">✓ 非做不可</span></td>
              </tr>
            </tbody>
          </table>
        </div>

        <p class="note">結論：VC 適用於<strong>長期權利、跨機構影響、或高度敏感</strong>的場景；一次性促銷用途則多為負擔。</p>
      </section>

      <hr class="div" />

      <!-- 三、「值得」的定義 -->
      <section>
        <h2 id="s3">三、「值得」的定義：當信任比速度重要</h2>
        <div class="grid2">
          <article class="card">
            <h3>高風險場景</h3>
            <p>如低收入戶卡被偽造，將造成補助濫領、資源錯配、系統失信——此時 VC 的防偽與撤銷能力至關重要。</p>
          </article>
          <article class="card">
            <h3>低風險場景</h3>
            <p>如 50 元折價券被複製，損失有限；導入 VC 反使體驗變差、維運成本偏高。</p>
          </article>
        </div>
        <div class="callout">
          <p><strong>判準：</strong>不要從「能不能」出發，而是問「失敗是否造成信任危機」。</p>
        </div>
      </section>

      <hr class="div" />

      <!-- 四、過度數位化的副作用 -->
      <section>
        <h2 id="s4">四、過度數位化的副作用</h2>
        <ul class="bullets">
          <li><strong>系統過度複雜：</strong>每個場景都簽章、驗證、公鑰同步，維運成本高。</li>
          <li><strong>使用者體驗下降：</strong>一次性優惠也要開錢包、授權，反而產生阻力。</li>
          <li><strong>稽核壓力過重：</strong>原本不需留痕的場景留下追蹤紀錄，暴露隱私。</li>
        </ul>
        <p>VC 的設計應聚焦「信任傳遞」，不是讓每個 QR Code 更花俏。</p>
      </section>

      <hr class="div" />

      <!-- 五、必要性 > 普及性 -->
      <section>
        <h2 id="s5">五、「必要性」比「普及性」重要</h2>
        <blockquote class="quote">
          「數位憑證不該被無限複製，而應該被精準使用。」
        </blockquote>
        <p>
          若場景沒有明確的信任風險、權益爭議、或跨機構驗證需求，就不該為了趨勢而引入 VC。
          與其追求普及，不如在真正需要信任的地方發揮價值。
        </p>
      </section>

      <hr class="div" />

      <!-- 六、小結 -->
      <section class="wrapup">
        <h2 id="s6">六、小結：VC 的價值在於慎用</h2>
        <p>
          折價券與票券屬於「方便」的世界，VC 屬於「信任」的世界。若一個憑證的本質是「我願意相信你」，那就該考慮 VC；
          若它只是「給你優惠」，別讓技術成為新的摩擦點。成熟的數位社會，懂得什麼時候用、什麼時候不用。
        </p>
      </section>

      <!-- 互動：迷你檢核清單（純前端） -->
      <section class="check">
        <h3 class="check-title">情境檢核：這個場景值得用 VC 嗎？</h3>
        <ul class="check-list">
          <li><input type="checkbox" disabled checked aria-hidden="true" /> 涉及長期權利或跨機構協作</li>
          <li><input type="checkbox" disabled checked aria-hidden="true" /> 偽造會造成顯著損害或信任危機</li>
          <li><input type="checkbox" disabled aria-hidden="true" /> 需要選擇性揭露或可撤銷機制</li>
          <li><input type="checkbox" disabled aria-hidden="true" /> 有能力維護簽章、公鑰與撤銷清單</li>
        </ul>
        <p class="note">（滿足多數條件再評估導入，否則採更輕量的數位化方案即可。）</p>
      </section>
    </article>
  </ArticleFrame>
</template>

<style scoped>
.post{
  --c-ink:#2b2b2b;
  --c-muted:#5a4e47;
  --c-primary:#b35f37;
  --c-accent:#e4b17c;
  --c-soft:#fff8f2;
  --c-surface:#fff;
  --c-line:#ead8c8;
  color:var(--c-ink);
  line-height:1.8;
}

/* 標題樣式 */
.post h2{
  margin:1.12rem 0 .55rem;
  font-size:1.12rem;
  color:var(--c-primary);
  display:inline-flex;align-items:center;gap:.45rem;
}
.post h2::before{
  content:"";
  width:10px;height:10px;border-radius:50%;
  background:radial-gradient(circle at 40% 40%,var(--c-accent),var(--c-primary));
  display:inline-block;
}

/* 導言 */
.lead{
  background:linear-gradient(180deg,#fffdf9,var(--c-soft));
  border:1px solid #f0e1d8;border-radius:12px;
  padding:.9rem 1rem;
}

/* 文字與列表 */
.post p{margin:.35rem 0 .75rem}
.bullets{margin:.35rem 0 .9rem 1.25rem}
.bullets li{margin:.22rem 0}

/* 分隔線 */
.div{
  border:0;height:1px;
  background:linear-gradient(90deg,#f0e6df,var(--c-line) 40%,#f0e6df);
  margin:1rem 0 1rem;
}

/* 對照表 */
.table-wrap{overflow-x:auto;border:1px solid #efe6de;border-radius:12px;background:#fff}
.cmp{width:100%;min-width:560px;border-collapse:collapse}
.cmp thead th{
  text-align:left;font-weight:700;font-size:.92rem;color:#835b46;
  background:#fff7f0;border-bottom:1px solid var(--c-line);padding:.55rem .7rem
}
.cmp tbody th{font-weight:700;color:#6e4b38}
.cmp tbody td,.cmp tbody th{padding:.55rem .7rem;border-bottom:1px solid #f2e7dd}
.cmp tbody tr:last-child td,.cmp tbody tr:last-child th{border-bottom:0}

/* 小徽章 */
.badge{display:inline-block;padding:.1rem .45rem;border-radius:999px;font-size:.82rem;font-weight:700}
.badge.bad{background:#ffe9e3;border:1px solid #f3c1b4;color:#9a3e2c}
.badge.maybe{background:#fff4da;border:1px solid #f0d9a6;color:#8a6a29}
.badge.good{background:#e7f6ef;border:1px solid #bfe3d0;color:#2a7a55}

/* 卡片網格 */
.grid2{display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:.85rem;margin-top:.35rem}
.card{
  background:var(--c-surface);border:1px solid #e8e0d9;border-radius:12px;
  padding:.8rem .95rem;box-shadow:0 2px 6px rgba(0,0,0,.04);
  transition:transform .2s ease,box-shadow .2s ease,border-color .2s ease
}
.card:hover{transform:translateY(-2px);border-color:#d27b4b33;box-shadow:0 8px 18px rgba(210,123,75,.14)}
.card h3{margin:0 0 .35rem;color:#b35f37;font-size:1rem}

/* Callout / 引文 */
.callout{
  border-left:4px solid var(--c-primary);
  background:linear-gradient(180deg,#fffdf9,var(--c-soft));
  padding:.75rem .9rem;border-radius:10px;margin-top:.45rem
}
.quote{
  background:#fff;border:1px solid #e8e0d9;border-radius:12px;
  padding:.85rem 1rem;color:#583d30;box-shadow:0 2px 6px rgba(0,0,0,.04)
}

/* 互動檢核（純樣式） */
.check{margin-top:.6rem}
.check-title{margin:.2rem 0 .4rem;color:#7a523f;font-size:1rem}
.check-list{list-style:none;padding:0;margin:0}
.check-list li{
  display:flex;align-items:center;gap:.5rem;
  background:#fff;border:1px solid #e8e0d9;border-radius:10px;
  padding:.5rem .7rem;margin:.4rem 0;box-shadow:0 2px 6px rgba(0,0,0,.03)
}
.check-list input{accent-color:#c96c3b}

/* 註解 */
.note{color:#7a6c63;font-size:.88rem}

/* RWD */
@media (max-width:768px){
  .post h2{font-size:1.06rem}
}
</style>
