# --- 1. 建置階段 (Builder Stage) ---
# 使用 Node.js 20 (LTS 版本) 作為基礎，Alpine 版本體積小
# (您本地用 v23 太新了，生產環境應使用 LTS 版本，例如 20.x 或 18.x)
FROM node:20-alpine AS builder

# 設定工作目錄
WORKDIR /app

# 複製 package.json 和 lock 檔案
COPY package.json package-lock.json* ./

# 安裝所有依賴 (包含 devDependencies，因為 build 需要)
RUN npm install

# 複製所有原始碼
COPY . .

# 執行 build (這會產生 .output 目錄)
RUN npm run build

# --- 2. 生產階段 (Production Stage) ---
FROM node:20-alpine AS production

# 設定工作目錄
WORKDIR /app

# 設定環境變數為 "production"
ENV NODE_ENV=production

# 從 "builder" 階段複製 .output 目錄
# 這是 Nuxt 3 build 完的獨立伺服器
COPY --from=builder /app/.output .

# 複製 package.json 和 lock 檔案 (為了安裝 "production" 依賴)
COPY package.json package-lock.json* ./

# 只安裝 "production" 依賴
# (例如 nuxt, vue, mermaid... 會被安裝)
# (tailwindcss, sass... 會被跳過，因為 runtime 不需要)
RUN npm install --production

# 設定 Nuxt 伺服器監聽所有 IP
ENV HOST=0.0.0.0
ENV PORT=3000

# 向 Docker 宣告容器將使用 3000 埠
EXPOSE 3000

# 容器啟動指令

# 建一個非 root 的使用者
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# 把程式檔案權限給這個使用者
WORKDIR /app
# 如果前面有 COPY . /app，記得確保權限
# RUN chown -R appuser:appgroup /app

# 之後的指令都用這個使用者跑
USER appuser
# 執行 .output/server/index.mjs
CMD ["node", "./server/index.mjs"]