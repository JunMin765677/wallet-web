// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: false },
  modules: [
    '@pinia/nuxt',
    '@nuxtjs/tailwindcss'
  ],

  devServer: {
    host: "0.0.0.0",
    port: 3000
  },

  // --- 這是最重要的修改 ---
  runtimeConfig: {
    // 這些是 "私有" 的，只在伺服器端可用
    // 我們將透過環境變數 NUXT_API_BASE 注入
    apiBase: '', // 預設值

    // "public" 內的金鑰會暴露給瀏覽器
    public: {
      // 如果瀏覽器也需要呼叫 API (在您的情境一中 "不需要")
      // 但我們保留結構以保持一致性
      // apiBase: '', // 瀏覽器不需要知道後端 API 位址
    }
  },

  // --- 刪除或註解掉 VITE 這整段 ---
  // vite: {
  //   server: {
  //     proxy: {
  //       '/api': {
  //         target: 'http://172.20.10.4:8001', 
  //         changeOrigin: true, 
  //       }
  //     }
  //   }
  // }
})