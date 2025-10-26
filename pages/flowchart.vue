<script setup>
import { onMounted } from 'vue'
// 確保您已經透過 npm install mermaid 安裝了 mermaid
import mermaid from 'mermaid'

// onMounted 確保 DOM 載入後才執行
onMounted(() => {
  mermaid.initialize({
    startOnLoad: true,
    theme: 'dark', // 使用深色主題
    flowchart: {
      useMaxWidth: true,
      htmlLabels: true
    }
  })
  
  // 如果 startOnLoad: true 沒有自動觸發，可以手動呼叫
  // mermaid.run(); 
})
</script>

<template>
  <!-- 
    使用 <ClientOnly> 包裹，確保 Mermaid.js 只在客戶端執行 
    這在 Nuxt 3 中是必要的，因為 Mermaid 需要存取 window 物件
  -->
  <ClientOnly>
    <div class="bg-gray-900 text-gray-100 p-4 md:p-8 font-sans min-h-screen">
      <div class="max-w-6xl mx-auto">
          
          <h1 class="text-3xl font-bold text-center mb-8 text-white">數位憑證 (VC) 業務流程圖</h1>
  
          <!-- Part 1: 簽發流程 -->
          <div class="bg-gray-800 rounded-lg shadow-xl p-6 mb-8">
              <h2 class="text-2xl font-semibold mb-6 text-center text-blue-300">Part 1: 簽發流程 (Issuance Pipeline)</h2>
              <!-- 
                Mermaid.js 會自動偵測 class="mermaid" 並將其轉換為圖表
                注意：所有樣式定義 (classDef) 都保留在圖表定義中
              -->
              <pre class="mermaid">
                  graph TD
                      subgraph "前端 (Issuer FE)"
                          A[民眾瀏覽網頁<br>點擊「模擬申請」]:::node-fe
                          D[顯示可申領 VC 列表]:::node-fe
                          F[民眾選擇申領 VC]:::node-fe
                          J[顯示 QR Code]:::node-fe
                      end
                  
                      subgraph "後端 (Issuer BE)"
                          B(隨機配發模擬身份<br>(Persons.id)):::node-be
                          C(<b>(核心)</b><br>檢查資格 vs 已領取)
                          E(接收申領請求<br>產生 system_uuid)
                          G(寫入 DB `IssuedVCs`<br>狀態: 'issuing')
                          H(呼叫 Sandbox `VcTransaction` API)
                          I(取得 transactionId, qrCode)
                          L(輪詢 Sandbox `VcCredential` API)
                          M{輪詢成功?}
                          N(<b>(成功)</b><br>解析 JTI 取得 CID<br>更新 `IssuedVCs` 狀態: 'issued'<br>更新 `IssuanceLogs` 狀態: 'user_claimed')
                          O(<b>(失敗/超時)</b><br>更新 `IssuedVCs` 狀態: 'expired')
                      end
                  
                      subgraph "資料庫 (Database)"
                          G -- 寫入 --> DB1(IssuedVCs):::node-db
                          H -- 讀取 --> DB2(Persons):::node-db
                          H -- 讀取 --> DB3(PersonEligibilities):::node-db
                          N -- 更新 --> DB1
                          O -- 更新 --> DB1
                      end
                  
                      subgraph "使用者 (User)"
                          K[民眾 App 掃碼<br>並同意領取]:::node-user
                      end
  
                      subgraph "Sandbox API"
                          H -- 呼叫 --> API1(VcTransaction):::node-api
                          L -- 輪詢 --> API2(VcCredential):::node-api
                      end
                  
                      %% 流程串接
                      A --> B
                      B --> C
                      C -- 找出可申領列表 --> D
                      D --> F
                      F --> E
                      E --> G
                      G --> H
                      H --> I
                      I --> J
                      J --> K
                      K -- 觸發輪詢 --> L
                      L --> M
                      M -- 是 --> N
                      M -- 否 --> O
  
                      %% 樣式定義 (Mermaid 內建)
                      classDef node-fe fill:#0284c7,stroke:#0369a1,color:#fff
                      classDef node-be fill:#059669,stroke:#047857,color:#fff
                      classDef node-user fill:#d97706,stroke:#b45309,color:#fff
                      classDef node-db fill:#7e22ce,stroke:#6b21a8,color:#fff
                      classDef node-api fill:#db2777,stroke:#be185d,color:#fff
              </pre>
          </div>
  
          <!-- Part 2: 驗證流程 -->
          <div class="bg-gray-800 rounded-lg shadow-xl p-6">
              <h2 class="text-2xl font-semibold mb-6 text-center text-green-300">Part 2: 驗證流程 (Verification Pipeline)</h2>
              <pre class="mermaid">
                  graph TD
                      subgraph "前端 (Verifier FE)"
                          A[驗證方 (醫院) 填寫目的<br>點擊「開始驗證」]:::node-fe
                          E[顯示 QR Code]:::node-fe
                          G[FE 開始輪詢 BE 狀態]:::node-fe
                          P[顯示最終驗證結果<br>(成功/失敗)]:::node-fe
                      end
  
                      subgraph "後端 (Issuer BE)"
                          B(接收請求<br>呼叫 Sandbox `VpRequest` API)
                          C(取得 transactionId, qrCode)
                          D(<b>(關鍵)</b><br>預先寫入 `VerificationLogs`<br>狀態: 'initiated')
                          H(BE 同步輪詢 Sandbox `VpResult` API)
                          I{輪詢成功?}
                          J{Sandbox 回傳<br>verifyResult: true?}
                          K(<b>(驗證失敗)</b><br>更新 Log 狀態: 'failed')
                          L{<b>(關鍵)</b><br>解析 Claims<br>成功找到 system_uuid?}
                          M(<b>(成功)</b><br>更新 Log 狀態: 'success'<br>回填 verified_vc_uuid)
                          N(<b>(異常)</b><br>更新 Log 狀態: 'error_missing_uuid')
                          O(<b>(失敗/超時)</b><br>更新 Log 狀態: 'expired')
                      end
  
                      subgraph "資料庫 (Database)"
                          D -- 寫入 --> DB1(VerificationLogs):::node-db
                          K -- 更新 --> DB1
                          M -- 更新 --> DB1
                          N -- 更新 --> DB1
                          O -- 更新 --> DB1
                      end
  
                      subgraph "使用者 (User)"
                          F[民眾 App 掃碼<br>並同意分享]:::node-user
                      end
  
                      subgraph "Sandbox API"
                          B -- 呼叫 --> API1(VpRequest):::node-api
                          H -- 輪詢 --> API2(VpResult):::node-api
                      end
  
                      %% 流程串接
                      A --> B
                      B --> C
                      C --> D
                      D --> E
                      E --> F
                      F -- 觸發輪詢 --> G
                      G -- 觸發 --> H
                      H --> I
                      I -- 否 --> O
                      I -- 是 --> J
                      J -- 否 --> K
                      J -- 是 --> L
                      L -- 是 --> M
                      L -- 否 --> N
                      K --> P
                      M --> P
                      N --> P
                      O --> P
  
                      %% 樣式定義 (Mermaid 內建)
                      classDef node-fe fill:#0284c7,stroke:#0369a1,color:#fff
                      classDef node-be fill:#059669,stroke:#047857,color:#fff
                      classDef node-user fill:#d97706,stroke:#b45309,color:#fff
                      classDef node-db fill:#7e22ce,stroke:#6b21a8,color:#fff
                      classDef node-api fill:#db2777,stroke:#be185d,color:#fff
              </pre>
          </div>
      </div>
    </div>
  </ClientOnly>
</template>

<style lang="scss" scoped>
/* 這裡是 SCSS 區塊。
  由於我們使用 Mermaid 內建的 classDef 來定義節點樣式，
  這裡不需要額外的 CSS。
  
  如果您需要覆蓋(override)特定樣式，可以使用 :deep() 選擇器，例如：
  :deep(.mermaid .node-fe) {
    font-weight: bold;
  }
*/
</style>
