<!-- pages/docs/[slug].vue -->
<script setup lang="ts">
import { computed, defineAsyncComponent } from 'vue'
import { useRoute } from 'vue-router'

/**
 * 對應所有目前在列表中的 slug → component。
 * 之後新增文章只要在 components/doc/articles/ 底下建立對應檔案，
 * 並在此處 registry 補上一行即可。
 */
const registry: Record<string, () => Promise<any>> = {
  // 現場應用篇
  'field-why-local-id':     () => import('~/components/doc/articles/FieldWhyLocalId.vue'),
  'field-disaster-id':      () => import('~/components/doc/articles/FieldDisasterId.vue'),
  'field-no-roster':        () => import('~/components/doc/articles/FieldNoRoster.vue'),
  'field-frequency-meaning':() => import('~/components/doc/articles/FieldFrequencyMeaning.vue'),
  'field-low-frequency':    () => import('~/components/doc/articles/FieldLowFrequency.vue'),

  // // 設計理念篇
  'design-sensitive-but-needed': () => import('~/components/doc/articles/DesignSensitiveButNeeded.vue'),
  'design-not-just-no-wallet':   () => import('~/components/doc/articles/DesignNotJustNoWallet.vue'),
  'design-when-vc-worth':        () => import('~/components/doc/articles/DesignWhenVcWorth.vue'),
  'design-zkp-privacy-trust':    () => import('~/components/doc/articles/DesignZkpPrivacyTrust.vue'),
  'design-sd-jwt-accessibility': () => import('~/components/doc/articles/DesignSdJwtAccessibility.vue'),

  // 技術與政策篇
  'policy-dynamic-eligibility':  () => import('~/components/doc/articles/PolicyDynamicEligibility.vue'),
  'policy-government-integration':() => import('~/components/doc/articles/PolicyGovernmentIntegration.vue'),
  'policy-auditability':         () => import('~/components/doc/articles/PolicyAuditability.vue'),
  'policy-onboarding-sectors':   () => import('~/components/doc/articles/PolicyOnboardingSectors.vue'),
  'policy-anti-fraud':           () => import('~/components/doc/articles/PolicyAntiFraud.vue'),

  // // 使用者觀點篇
  'user-why-credentials':  () => import('~/components/doc/articles/UserWhyCredentials.vue'),
  'user-accessibility':     () => import('~/components/doc/articles/UserAccessibility.vue'),
  'user-trust-privacy':     () => import('~/components/doc/articles/UserTrustPrivacy.vue'),
  // 'user-card-design':       () => import('~/components/doc/articles/UserCardDesign.vue'),
  'user-biometrics':        () => import('~/components/doc/articles/UserBiometrics.vue'),

  // // 延伸思考篇
  'future-next-domain':     () => import('~/components/doc/articles/FutureNextDomain.vue'),
  'future-public-private':  () => import('~/components/doc/articles/FuturePublicPrivate.vue'),
  'future-abuse-prevention':() => import('~/components/doc/articles/FutureAbusePrevention.vue'),
  'future-metrics-trust':   () => import('~/components/doc/articles/FutureMetricsTrust.vue'),
  'future-visibility-ethics':() => import('~/components/doc/articles/FutureVisibilityEthics.vue'),
}

const route = useRoute()
const slug = computed(() => String(route.params.slug || ''))
const ArticleComp = computed(() => {
  const loader = registry[slug.value]
  return loader ? defineAsyncComponent(loader) : null
})
</script>

<template>
  <main class="article-entry" role="main">
    <component v-if="ArticleComp" :is="ArticleComp" />
    <section v-else class="not-found">
      <h1 class="nf-title">找不到這篇文件</h1>
      <p class="nf-desc">請回到<a href="/docs">文件中心</a>重新選擇主題。</p>
    </section>
  </main>
</template>

<style scoped>
.article-entry {
  padding: 2rem 1.25rem 3rem;
  color: #2b2b2b;
}

/* 404 頁面 */
.not-found {
  text-align: center;
  padding: 3rem 1rem;
}
.nf-title {
  font-size: 1.5rem;
  margin: 0 0 .5rem;
  color: #b35f37;
}
.nf-desc a {
  color: #b35f37;
  text-decoration: underline;
}

/* * RWD 設定
 * 當螢幕寬度小於等於 768px 時套用
 */
@media (max-width: 768px) {
  .article-entry {
    /* * 調整：減少垂直 padding，
     * 並將左右 padding 設為 0.75rem，
     * 與 index 頁保持一致，讓文章內容更寬。
     */
    padding: 1.5rem 0.75rem 2rem;
  }
  .not-found {
    /* 減少 404 頁面的垂直 padding */
    padding: 2rem 1rem;
  }
  .nf-title {
    /* 縮小 404 標題 */
    font-size: 1.3rem;
  }
}
</style>