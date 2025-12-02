
-----

# 數位憑證模擬平台 (暖心e憑證) - 前端專案

本專案是「暖心e憑證」數位憑證平台的 Nuxt 3 前端應用程式。

它模擬了完整的數位社福憑證生命週期，包含三大核心功能：**民眾申領**、**單位驗證**，以及**後台管理**。

## ✨ 核心功能

本專案主要由三大使用者流程（頁面）組成：

### 1\. 民眾申領流程 (`/`)

模擬民眾 (Citizen) 申領數位憑證的流程。

  * **步驟 1: 身份驗證**： 模擬健保卡或行動自然人憑證驗證。
  * **步驟 2: 選擇憑證**： 顯示該民眾符合資格的憑證列表 (例如：低收入戶證明、身心障礙證明)。
  * **步驟 3: 掃描領取**：
      * 產生專屬的 QR Code 及 Deep Link。
      * 前端開始輪詢 (`/api/issuance/status/[txId]`) API。
  * **步驟 4: 狀態更新**： 輪詢 API 回傳 `issued` (已領取) 或 `expired` (已過期) 時，即時更新 UI 狀態。

### 2\. 單位驗證流程 (`/verify`)

模擬驗證方 (Verifier)，如醫院櫃檯、社福單位承辦人，驗證民眾憑證的介面。

  * **步驟 1: 歡迎畫面**： 顯示 Logo Splash 歡迎動畫。
  * **步驟 2: 角色選擇**： 驗證方使用 Icon 按鈕選擇自己的角色 (例如：醫療機構、慈善機構)。
  * **步驟 3: 模擬登入**： 顯示一個模擬的登入中動畫。
  * **步驟 4: 驗證設定**：
      * 顯示歡迎訊息 (例如：歡迎 林口長壽醫院)。
      * 選擇 **單次驗證 (Single)** 或 **批次驗證 (Batch)** 模式。
      * 填寫驗證目的 (例如：一般就醫) 與備註。
  * **步驟 5: 顯示 QR Code**：
      * 呼叫 (`/api/verification/request-verification`) API 取得 QR Code。
      * 顯示 API 回傳的「過期倒數計時器」 (`expiresAt`)。
      * 顯示本次驗證的資訊 (單位、目的) 供民眾確認。
  * **步驟 6: 顯示結果 (流程分岔)**：
      * **(單次模式)**：
          * 輪詢 `check-status/[txId]` API。
          * 成功或失敗時，*取代* QR Code，顯示**單一**詳細結果 (`VerificationResultDetail`)。
      * **(批次模式)**：
          * 輪詢 `check-batch-status/[uuid]` API。
          * **保持** QR Code 顯示，供下一位民眾掃描。
          * 在 QR Code 下方即時顯示「已驗證列表」(`BatchResultList`)。

### 3\. 後台管理系統 (`/admin`)

提供系統管理員 (Admin) 稽核與管理所有憑證與資格的介面。

  * **資格總覽 (`/admin/templates`)**

      * (FE-1 / 表1) 顯示所有「福利種類」的統計儀表板。
      * 表格包含：卡片縮圖、福利名稱、總資格數、已領取、待領取。

  * **名冊管理 (`/admin/templates/[templateId]`)**

      * (FE-2) 顯示特定福利的「民眾名冊 (Roster)」。
      * 支援「搜尋」(姓名/身分證號) 與「分頁」。
      * **查看詳情**：點擊開啟 `PersonDetailModal`，顯示該民眾所有個資 (包含財產、聯絡人等)。
      * **註銷資格** (FE-3)：
          * 點擊開啟 `RevokeConfirmModal` 確認彈窗。
          * 呼叫 `POST /api/vle/admin/eligibility/revoke` API。
          * 成功後自動 `refresh` (重新整理) 名冊資料。

  * **簽發日誌 (`/admin/logs/issuance`)**

      * (表2) 顯示所有「申領事件」的稽核日誌。
      * 依時間倒序、可分頁，顯示申領時間、民眾、福利種類、申領狀態 (`user_claimed` / `expired`...)、憑證狀態 (`issued` / `revoked`...) 等。

  * **驗證日誌 (`/admin/logs/verification`)**

      * (表3) 顯示所有「驗證事件」的稽核日誌。
      * 支援「統一搜尋」(可搜機構、民眾、福利...) 與「分頁」。
      * 顯示驗證時間、驗證機構、目的、民眾、結果 (成功/失敗)、驗證的福利身份列表等。

## 🛠️ 使用技術

  * **框架:** Nuxt 3 (Vue 3)
  * **語言:** TypeScript
  * **樣式:** SCSS (Scoped)
  * **API 請求:** `useFetch` / `$fetch` (搭配 `async/await`)
  * **狀態管理:** Vue 3 Composition API (`ref`, `computed`, `watch`)
  * **核心功能:**
      * 生命週期鉤子 (`onMounted`, `onUnmounted`, `onActivated`, `onDeactivated`) 用於管理輪詢與頁面狀態重置。
      * Nuxt 動態路由 (`pages/admin/templates/[templateId].vue`)。
      * Nuxt 路由守衛 (`watch` + `router.push`) 用於實作搜尋與分頁。
      * `<ClientOnly>` (用於修復 Admin 頁面的 Hydration Mismatch)。
      * `<Teleport>` (用於 `PersonDetailModal` 和 `RevokeConfirmModal` 彈窗)。

## 🚀 專案啟動

### 1\. 安裝依賴

```bash
npm install
```

### 2\. 設定環境變數

本專案透過 `nuxt.config.ts` 的 `runtimeConfig` 來管理 API 路徑。

請在專案根目錄建立一個 `.env` 檔案，並填入後端 API 伺服器的 URL：

```env
# 後端 API 伺服器的基礎 URL
NUXT_PUBLIC_API_BASE="http://localhost:8001"
```

### 3\. 啟動開發伺服器

應用程式將運行在 `http://localhost:3000`

```bash
npm run dev
```

### 4\. 編譯與打包 (Production)

```bash
npm run build
```

-----

## 📁 專案結構 (重點)

```
/pages
├── index.vue                # 1. 民眾申領流程
├── verify/
│   └── index.vue            # 2. 單位驗證流程
└── admin/
    ├── templates/
    │   ├── index.vue        # 3.1 資格總覽 (FE-1 / 表1)
    │   └── [templateId].vue # 3.2 名冊管理 (FE-2)
    └── logs/
        ├── issuance.vue     # 3.3 簽發日誌 (表2)
        └── verification.vue # 3.4 驗證日誌 (表3)

/components
├── Step1Verification.vue    # 申領: 步驟 1
├── Step2Issuance.vue        # 申領: 步驟 2 (列表)
│
├── VerifySplash.vue         # 驗證: 歡迎畫面
├── VerifyStep1RoleSelection.vue # 驗證: 角色選擇
├── VerifyStep1Form.vue      # 驗證: 填寫表單 (模式/目的)
├── VerifyStep2Status.vue    # 驗證: QR/結果 (單次/批次 路由)
├── BatchResultList.vue      # 驗證: (批次) 即時結果列表
├── VerificationResultDetail.vue # 驗證: (可重用) 單一成功結果
│
├── PersonDetailModal.vue    # Admin: (名冊) 民眾詳情 Modal
├── RevokeConfirmModal.vue   # Admin: (名冊) 註銷確認 Modal
└── Loading.vue              # (共用) 模擬登入動畫

nuxt.config.ts               # (環境變數在此設定)


### 授權

本專案採用 MIT 開源授權，詳細條款請見 LICENSE。

```
