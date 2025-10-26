<script setup lang="ts">
import { useRuntimeConfig, useFetch } from 'nuxt/app' 
const config = useRuntimeConfig()
const { data, pending, error, refresh } = await useFetch(`${config.public.apiBase}/healthz`, {
  headers: { 'Accept': 'application/json' }
})
</script>

<template>
  <section style="max-width: 680px; margin: 40px auto; font-family: ui-sans-serif, system-ui;">
    <h1 style="font-size: 28px; font-weight: 700; margin-bottom: 8px;">Wallet MVP Demo</h1>
    <p style="color:#666; margin-bottom: 24px;">Nuxt3 前端 ⇄ Express 後端 ⇄ 沙盒 API</p>

    <div style="padding:16px; border:1px solid #eee; border-radius:12px;">
      <h2 style="font-weight:600; margin-bottom: 8px;">後端健康檢查</h2>

      <div v-if="pending">檢查中…</div>
      <div v-else-if="error" style="color:#b33;">無法連線：{{ (error as any)?.message }}</div>
      <pre v-else style="background:#fafafa; padding:12px; border-radius:8px; overflow:auto;">
        {{ JSON.stringify(data, null, 2) }}
      </pre>

        <button
        @click="() => refresh()"
        style="margin-top:12px; padding:8px 12px; border:1px solid #ddd; border-radius:8px;"
        >
        重新整理
        </button>
    </div>
  </section>
</template>
