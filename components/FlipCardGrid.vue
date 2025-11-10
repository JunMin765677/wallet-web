<template>
  <div class="wrapper">
    <h2 class="grid-title">憑證類型</h2>
    <div class="cols">
      <div v-for="(c, i) in cards" :key="i" class="col">
        <FlipCard
          :title="c.title"
          :subtitle="c.subtitle"
          :image-url="c.image"
          :back-text="c.back"
        />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import FlipCard from '@/components/FlipCard.vue'

const cards = [
  {
    title: '醫療機構',
    subtitle: '適用院所 / 藥局',
    image: 'https://images.unsplash.com/photo-1586773860418-d37222d8fce3?q=80&w=1200&auto=format&fit=crop',
    back: '醫療機構可出示醫療相關的專業身份，並在核驗端完成授權作業與紀錄保存。',
  },
  {
    title: '慈善機構',
    subtitle: '社福 / NGO',
    image: 'https://images.unsplash.com/photo-1532629345422-7515f3d16bb6?q=80&w=1200&auto=format&fit=crop',
    back: '慈善組織可使用此憑證核驗服務資格，並進行跨單位合作查驗。',
  },
  {
    title: '災害應變中心',
    subtitle: '橫向聯防',
    image: 'https://images.unsplash.com/photo-1519681393784-d120267933ba?q=80&w=1200&auto=format&fit=crop',
    back: '災防中心在事件期間可快速核驗人員身分與任務授權，降低溝通成本。',
  },
]
</script>

<style scoped>
.wrapper{ width: 100%; max-width: 80rem; margin: 0 auto; padding: .5rem; }
.grid-title{ text-align:center; margin: 0 0 1rem; font-weight:800; color:#2b3643; }
.cols{ display:flex; flex-wrap:wrap; justify-content:center; }
.col{ width: calc(33.333% - 1.5rem); margin:.75rem; }
@media (max-width: 64rem){ .col{ width: calc(50% - 1.5rem); } }
@media (max-width: 40rem){ .col{ width: 100%; margin: 0 0 1rem 0; } }
</style>
