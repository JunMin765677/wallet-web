<!-- components/VerificationResultDetail.vue -->
<template>
  <div v-if="verificationData" class="vrd">
    <!-- Header：主標題＋數量 -->
    <header class="hdr">
      <h3 class="title">驗證結果</h3>
      <span class="chip">{{ vcCount }}</span>
      <span class="chip-label">張憑證</span>
    </header>

    <!-- 合併版面：左＝資料總覽，右＝卡片清單 -->
    <section class="layout">
      <!-- 左側：資料總覽 -->
      <aside class="col info-col">
        <div class="panel">
          <h4 class="panel-title">個人資料</h4>
          <ul class="kv">
            <li><span>姓名</span><strong>{{ verificationData.person.name }}</strong></li>
            <li><span>身分證字號</span><strong class="mono">{{ verificationData.person.nationalId }}</strong></li>
          </ul>
        </div>

        <div class="panel">
          <h4 class="panel-title">緊急聯絡人</h4>
          <ul class="kv">
            <li><span>姓名</span><strong>{{ verificationData.contact.emergencyContactName }}</strong></li>
            <li><span>關係</span><strong>{{ verificationData.contact.emergencyContactRelationship }}</strong></li>
            <li><span>電話</span><strong class="mono">{{ verificationData.contact.emergencyContactPhone }}</strong></li>
          </ul>
        </div>

        <div class="panel">
          <h4 class="panel-title">審核資訊</h4>
          <ul class="kv">
            <li><span>審核機關</span><strong>{{ verificationData.reviewer.reviewingAuthority }}</strong></li>
            <li><span>審核人員</span><strong>{{ verificationData.reviewer.reviewerName }}</strong></li>
            <li><span>聯絡電話</span><strong class="mono">{{ verificationData.reviewer.reviewerPhone }}</strong></li>
          </ul>
        </div>
      </aside>

      <!-- 右側：卡片清單 -->
      <main class="col cards-col">
        <h4 class="cards-title">已驗證的福利資格</h4>

        <div v-if="vcCount > 0" class="cards-grid">
          <article
            v-for="cred in verificationData.verifiedCredentials"
            :key="cred.templateName + '::' + (cred.benefitLevel || '')"
            class="card"
          >
            <div class="img-wrap">
              <img
                :src="cred.cardImageUrl"
                :alt="cred.templateName || '已驗證憑證'"
                class="img"
                loading="lazy"
                decoding="async"
                @error="onImgError"
              />
            </div>
            <div class="meta">
              <span class="name" :title="cred.templateName">{{ cred.templateName }}</span>
              <span v-if="cred.benefitLevel" class="level">{{ cred.benefitLevel }}</span>
            </div>
          </article>
        </div>

        <div v-else class="empty">
          目前沒有可顯示的福利資格卡片。
        </div>
      </main>
    </section>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  verificationData: {
    person: { name: string; nationalId: string };
    contact: {
      emergencyContactName: string;
      emergencyContactRelationship: string;
      emergencyContactPhone: string;
    };
    reviewer: {
      reviewingAuthority: string;
      reviewerName: string;
      reviewerPhone: string;
    };
    verifiedCredentials: {
      templateName: string;
      benefitLevel: string;
      cardImageUrl: string;
    }[];
  };
}>()

const vcCount = computed(() => props.verificationData?.verifiedCredentials?.length ?? 0)

function onImgError(e: Event) {
  const el = e.target as HTMLImageElement
  const svg =
    'data:image/svg+xml;utf8,' +
    encodeURIComponent(
      `<svg xmlns="http://www.w3.org/2000/svg" width="640" height="400" viewBox="0 0 640 400">
        <rect width="100%" height="100%" fill="#f2f4f7"/>
        <g fill="#94a3b8" font-family="sans-serif" font-size="18">
          <text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle">無法載入卡片影像</text>
        </g>
      </svg>`
    )
  el.src = svg
}
</script>

<style lang="scss" scoped>
.vrd{
  --radius:.75rem;
  --gap:1rem;
  --line:#e2e8f0;
  --ink:#1f2937;
  --muted:#6b7280;
  --soft:#f7fafc;
  --chip-bg:#eef2f7;
  --chip-ink:#334155;
}

/* Header */
.hdr{
  display:flex; align-items:center; gap:.5rem;
  margin-bottom:.75rem;
}
.title{
  font-size:1.125rem; font-weight:800; color:#2d3748;
}
.chip{
  display:inline-flex; align-items:center; justify-content:center;
  min-width:1.6rem; height:1.25rem; padding:0 .5rem;
  border-radius:999px; font-weight:800; font-size:.8rem;
  background:var(--chip-bg); color:var(--chip-ink); border:1px solid #e5e7eb;
}
.chip-label{ font-size:.85rem; color:#64748b }

/* Layout */
.layout{
  display:grid; gap:var(--gap);
  grid-template-columns: 1fr; /* mobile: 單欄 */
}
@media (min-width: 960px){
  .layout{ grid-template-columns: 420px 1fr } /* 桌機：左窄右寬 */
}

.col{ display:flex; flex-direction:column; gap:var(--gap) }

/* Info panels (left) */
.panel{
  background:#fff; border:1px solid var(--line); border-radius:.5rem; overflow:hidden;
}
.panel-title{
  font-size:.9rem; font-weight:800; color:#4a5568;
  padding:.6rem .8rem; background:var(--soft); border-bottom:1px solid var(--line);
}
.kv{
  list-style:none; margin:0; padding:0;
}
.kv li{
  display:flex; justify-content:space-between; gap:.75rem;
  padding:.75rem .85rem; font-size:.9rem; border-bottom:1px solid var(--line);
}
.kv li:last-child{ border-bottom:0 }
.kv span{ color:var(--muted); flex-shrink:0 }
.kv strong{ color:#111827; font-weight:700; text-align:right; word-break:break-all }
.mono{ font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono","Courier New", monospace; }

/* Cards (right) */
.cards-title{
  font-size:.95rem; font-weight:800; color:#334155; margin:0 .2rem;
}
.cards-grid{
  display:grid; gap:1rem;
  grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
}
.card{
  background:#fff; border:1px solid var(--line); border-radius:var(--radius);
  overflow:hidden; box-shadow:0 6px 16px rgba(0,0,0,.04);
  transition: transform .06s ease, box-shadow .2s ease, border-color .2s ease;
}
.card:hover{ transform: translateY(-1px); box-shadow:0 10px 22px rgba(0,0,0,.06); border-color:#dbe3ea }

.img-wrap{ background:#f8fafc; border-bottom:1px solid var(--line) }
.img{ width:100%; aspect-ratio:16/10; object-fit:cover; display:block }

.meta{ padding:.75rem 1rem }
.name{
  display:block; font-weight:700; color:#111827; font-size:.92rem;
  white-space:nowrap; overflow:hidden; text-overflow:ellipsis;
}
.level{ display:block; font-size:.85rem; color:#3b82f6; font-weight:600; margin-top:.25rem }

.empty{
  padding:1rem; text-align:center; color:#7c858e;
  border:1px dashed var(--line); border-radius:.5rem; background:#f9fbfd;
}
</style>
