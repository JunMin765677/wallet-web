<script setup lang="ts">
import FlipCard from '@/components/FlipCard.vue'

export interface RoleOption {
  key: string
  name: string
  icon: string      // 保留欄位但不再顯示 emoji
  organizationName: string
  desc: string

}

const emit = defineEmits<{
  (e: 'role-selected', role: RoleOption): void
}>()

// 與你原始資料一致（不使用 emoji 顯示）
const roleOptions: RoleOption[] = [
  {
    key: 'medical',
    name: '醫療機構',
    icon: '🏥',
    organizationName: '林口長壽醫院',
    desc: '適用門診/住院結帳與社工轉介，快速確認補助或身障等級；僅回傳是否具資格與有效期限，不揭露病歷或收入明細。',
  },
  {
    key: 'charity',
    name: '慈善機構',
    icon: '🤝',
    organizationName: '大樹基金會',
    desc: '物資發放與補助審核現場即時核對受助資格；支援批次驗證，避免個資外流與資源錯置。',
  },
  {
    key: 'local_office',
    name: '里辦公處',
    icon: '🏘️',
    organizationName: '仁愛里辦公處',
    desc: '外勤訪查核對身障/中低老人等資格，帶著手機就開工，即時提供諮詢。',
  },
  {
    key: 'police_fire',
    name: '警察/消防',
    icon: '🚓',
    organizationName: '公園前派出所',
    desc: '出現急難狀況時，快速確認弱勢標註(例如身障)與家屬緊急聯絡資訊。有助於申請急難救助。',
  },
  {
    key: 'long_term_care',
    name: '長照機構/人員',
    icon: '👵',
    organizationName: '大樹長照中心',
    desc: '居家服務與申請補助核對使用者社福資格，降低弱勢老人申請成本與門檻。',
  },
  {
    key: 'legal_aid',
    name: '法律扶助',
    icon: '⚖️',
    organizationName: '法律扶助基金會大樹分會',
    desc: '啟動扶助評估時確認經濟弱勢或特定身分，降低弱勢民眾申請成本與門檻。',
  },
  {
    key: 'high_school',
    name: '國高中',
    icon: '🏫',
    organizationName: '桃園市立大樹高中',
    desc: '校內補助、營隊或優惠資格核對，保護隱私同時強化信任。',
  },
  {
    key: 'university',
    name: '大專院校',
    icon: '🎓',
    organizationName: '國立大樹大學',
    desc: '校內補助、宿舍與工讀資格查驗，保護隱私同時強化信任。',
  },
  {
    key: 'disability_aid',
    name: '身障輔具特約商',
    icon: '♿',
    organizationName: '公園前銀髮生活輔具行',
    desc: '門市核對補助等級以辦理申請與計價，降低弱勢老人申請成本與門檻。',
  },
  {
    key: 'disaster_center',
    name: '災害應變中心',
    icon: '🚨',
    organizationName: '大樹市災害應變中心',
    desc: '大規模災害分流與物資派發現場使用，支援批次 QR 驗證，即時辨識立即需要協助的人。',
  },
  {
    key: 'social_worker',
    name: '社工',
    icon: '❤️',
    organizationName: '大樹市政府社會局',
    desc: '外勤家訪與轉介作業快速核對身份與效期；可搭配備註留下情境說明，即時提供諮詢。',
  },
  {
    key: 'social_ticket',
    name: '社福身份優惠票券',
    icon: '🎟️',
    organizationName: '臺北市立動物園',
    desc: '售票/入場時驗證是否具社福優惠資格，保護隱私同時強化信任。',
  },
]

// 正面副標：長字會自動截斷（樣式裡已做 ellipsis）
function roleSubtitle(role: RoleOption) {
  return role.organizationName || ''
}

// 依 key 指派背景圖（自動對應 roleOptions 順序 001 ~ 012）
function roleImage(key: string): string {
  // 尋找 key 在 roleOptions 陣列中的索引 (位置)
  const index = roleOptions.findIndex(role => role.key === key)

  // 如果找不到 (index === -1)，就預設為 1，否則就是 索引+1
  const imageNumber = index === -1 ? 1 : index + 1

  // 將數字轉換為三位數的字串 (例如 1 -> "001", 12 -> "012")
  const paddedNumber = imageNumber.toString().padStart(3, '0')

  return `/role/${paddedNumber}.svg`
}

function select(role: RoleOption) {
  emit('role-selected', role)
}
</script>

<template>
  <div>
    <p class="subtitle">步驟 1: 選擇您的角色</p>

    <div class="role-grid">
      <div
        v-for="role in roleOptions"
        :key="role.key"
        class="col"
      >
        <FlipCard
          :title="role.name"
          :subtitle="roleSubtitle(role)"
          :image-url="roleImage(role.key)"
        >
          <div class="card-back">
            <p class="desc">
               {{ role.desc }} 
            </p>
            <button class="pick-btn" type="button" @click="select(role)">
              選擇此角色
            </button>
          </div>
        </FlipCard>
      </div>
    </div>
  </div>
</template>


<style lang="scss" scoped>
/* 色票（與整體一致的低飽和系） */
$ink-800: #2a3442;
$ink-600: #4a596d;
$ink-300: #8da0b6;
$ink-200: #dfe6ee;
$ink-100: #e9eff6;
$blue-600:#3a6ea5;
$blue-700:#2f5b88;

.subtitle {
  font-size: 1rem;
  color: #d0a07e;
  text-align: center;
  margin-bottom: 1.25rem;
  border-bottom: 1px solid $ink-100;
  padding-bottom: .9rem;
  letter-spacing: .02em;
}

/* 網格（沿用你之前的 2/3 欄 RWD） */
.role-grid {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  margin: 0 -.75rem;
}
.col {
  width: calc(50% - 1.5rem);
  margin: .75rem;
  @media (min-width: 640px) {
    width: calc(33.333% - 1.5rem);
  }
}

/* 背面 slot 的文案與按鈕 */
.card-back {
  display: grid;
  gap: .75rem;
  text-align: center;
}
.card-back .org {
  margin: 0;
  font-weight: 800;
  color: $ink-800;
  font-size: 1.05rem;
  line-height: 1.35;
  /* 過長時優雅截斷 */
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
.card-back .desc {
  margin: 0;
  color: $ink-600;
  font-size: .95rem;
  line-height: 1.65;
}
.pick-btn {
  margin-top: .25rem;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: .55rem 1rem;
  border-radius: .6rem;
  border: 1px solid $ink-200;
  background: linear-gradient(180deg, #f7fbff 0%, #ffffff 100%);
  color: $blue-700;
  font-weight: 800;
  font-size: .95rem;
  cursor: pointer;
  box-shadow: 0 6px 16px rgba(58,110,165,.08);
  transition: transform .08s ease, box-shadow .2s ease, border-color .2s ease, color .2s ease;

  &:hover {
    border-color: rgba(58,110,165,.35);
    box-shadow: 0 10px 24px rgba(58,110,165,.12);
    transform: translateY(-1px);
    color: $blue-600;
  }
  &:active { transform: translateY(0); }
}

/* 正面副標（FlipCard 裡的 subtitle）在手機做截斷，避免擠爆 */
:deep(.flip-card__subtitle) {
  display: block;
  max-width: 92%;
  margin: 0 auto;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* === Mobile 調整（<= 480px）=== */
@media (max-width: 480px) {
  /* 1) 正面不要顯示 organizationName（FlipCard 的 subtitle） */
  :deep(.flip-card__subtitle) {
    display: none !important;
  }

  /* 2) 背面不要顯示 organizationName（本元件的 .org） */
  .card-back .org {
    display: none !important;
  }

  /* 3) 背面描述保留，但字體縮小、行距緊一點 */
  .card-card .desc {
    display: block !important;
    font-size: .82rem;   /* 原本較大 → 縮小 */
    line-height: 1.45;   /* 稍微緊實 */
    color: #667685;      /* 低飽和 */
    margin-top: .25rem;
  }

  /* 5) 卡片高度略降（可選） */
  :deep(.flip-card__face) {
    min-height: 210px;
  }
}


/* === Mobile 按鈕再縮小 & 提升可點範圍（<= 480px）=== */
@media (max-width: 480px) {
  .pick-btn {
    /* 視覺上更小 */
    padding: .36rem .64rem;   /* 原 .42rem .7rem */
    border-radius: .48rem;
    font-size: .82rem;        /* 原 .85rem */
    line-height: 1.1;

    /* 降一點層級感，避免太重 */
    box-shadow: 0 3px 10px rgba(58,110,165,.08);
  }

  /* 提升觸控命中率：擴大不可見點擊區，不改變視覺大小 */
  .pick-btn {
    position: relative;
  }
  .pick-btn::after {
    content: '';
    position: absolute;
    inset: -6px;              /* 四周各多 6px 的熱區 */
    border-radius: .6rem;
  }
  .pick-btn:active {
    transform: translateY(0); /* 行動裝置避免位移過大 */
  }

  /* 若背面內容偏擠，可微調卡片內距 */
  .card-back { gap: .6rem; }
}


</style>