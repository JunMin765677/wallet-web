<!-- components/FlipCard.ssr-safe.vue -->
<template>
  <div class="flip-card">
    <!-- 用 div[role=button]，避免 SSR 初始 aria/state 分歧；mounted 後再接手互動 -->
    <div
      ref="root"
      class="flip-card__container"
      role="button"
      tabindex="0"
      @click="onToggle"
      @keydown.enter.prevent="onToggle"
      @keydown.space.prevent="onToggle"
    >
      <!-- 正面 -->
      <div class="flip-card__face flip-card__front" :style="bgStyle">
        <div class="flip-card__inner">
          <h3 class="flip-card__title">{{ title }}</h3>
          <p v-if="subtitle" class="flip-card__subtitle">{{ subtitle }}</p>
        </div>
      </div>

      <!-- 背面 -->
      <div class="flip-card__face flip-card__back">
        <div class="flip-card__inner">
          <slot>
            <p class="flip-card__text">{{ backText }}</p>
          </slot>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'

const props = withDefaults(defineProps<{
  title: string
  subtitle?: string
  imageUrl?: string
  backText?: string
  /** 想要預設翻面：為避免 SSR/CSR 不一致，會在 mounted 後才套用 */
  defaultFlipped?: boolean
}>(), {
  subtitle: '',
  imageUrl: '',
  backText: '',
  defaultFlipped: false,
})

const root = ref<HTMLElement | null>(null)

const bgStyle = computed(() => ({
  backgroundImage: props.imageUrl ? `url("${props.imageUrl}")` : 'none',
}))

function onToggle() {
  // 僅在客戶端執行：切換 .is-forced（不影響 SSR 初始結構）
  root.value?.classList.toggle('is-forced')
}

onMounted(() => {
  // 若要預設翻面，mounted 後再加 class，避免 hydration mismatch
  if (props.defaultFlipped) {
    root.value?.classList.add('is-forced')
  }
})
</script>

<style scoped lang="scss">
/* 低飽和藍灰系 */
$ink-800: #2a3442;
$ink-600: #4a596d;
$ink-300: #8da0b6;
$ink-100: #e6edf6;

.flip-card {
  width: 100%;
  position: relative;
}

.flip-card__container {
  position: relative;
  width: 100%;
  cursor: pointer;
  outline: none;

  /* 3D 場景 */
  transform-style: preserve-3d;
  perspective: 1000px;
}

/* 正反面共用 */
.flip-card__face {
  position: relative;
  min-height: 280px;
  border-radius: 12px;
  box-shadow: 0 10px 24px rgba(23, 43, 77, .12);
  backface-visibility: hidden;
  -webkit-backface-visibility: hidden;
  transform-style: preserve-3d;
  transition: transform .7s cubic-bezier(0.4, 0.2, 0.2, 1);
}

/* 正面：背景圖 + 偽元素遮罩（不增加子節點，SSR/CSR 子數一致） */
.flip-card__front {
  background-size: cover;
  background-position: center;
  background-color: #eef4fb;
}
.flip-card__front::after {
  content: '';
  position: absolute; inset: 0;
  background: rgba(0,0,0,.35);
  border-radius: 12px;
}

/* 內文（置中 + Z 軸拉起） */
.flip-card__inner {
  position: absolute; inset: 0;
  display: grid;
  place-content: center;
  text-align: center;
  padding: 1.5rem;
  transform: translateZ(60px) scale(.98);
}

.flip-card__title {
  margin: 0 0 .75rem 0;
  color: #fff;
  font-weight: 800;
  font-size: 1.35rem;
  letter-spacing: .02em;
}
.flip-card__subtitle {
  margin: 0;
  color: rgba(255,255,255,.8);
  font-weight: 600;
  font-size: .95rem;
}

/* 背面：柔和漸層 + 深色字 */
.flip-card__back {
  position: absolute; inset: 0;
  background: linear-gradient(180deg, #f7fbff 0%, #ffffff 100%);
  border: 1px solid $ink-100;
  color: $ink-800;
  transform: rotateY(180deg);
}
.flip-card__text {
  margin: 0;
  line-height: 1.65;
  font-size: .98rem;
  color: $ink-600;
}

/* 互動觸發：純 CSS :hover 與 .is-forced（mounted 後才會出現） */
.flip-card__container:hover .flip-card__front,
.flip-card__container.is-forced .flip-card__front {
  transform: rotateY(-180deg);
}
.flip-card__container:hover .flip-card__back,
.flip-card__container.is-forced .flip-card__back {
  transform: rotateY(0deg);
}

/* 無障礙：聚焦外框（不影響節點數） */
.flip-card__container:focus-visible {
  outline: 2px solid #4a7eb6;
  outline-offset: 4px;
}

/* RWD 高度微調（手機更緊湊） */
@media (max-width: 480px) {
  .flip-card__face { min-height: 220px; }
  .flip-card__title { font-size: 1.2rem; }
}

/* 尊重減少動畫偏好 */
@media (prefers-reduced-motion: reduce) {
  .flip-card__face { transition: none; }
}
</style>
