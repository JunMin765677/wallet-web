<template>
  <div class="app-container">
    <header class="app-header">
      <nav class="app-nav">
        <NuxtLink to="/" class="nav-link">首頁</NuxtLink>
        <NuxtLink to="/issuer" class="nav-link">簽發</NuxtLink>
        <NuxtLink to="/verifier" class="nav-link">驗證</NuxtLink>
        <NuxtLink to="/issuer-manage" class="nav-link">VC管理</NuxtLink>
        <NuxtLink to="/verifier-manage" class="nav-link">驗證紀錄</NuxtLink>
      </nav>
    </header>
    <main class="app-main">
      <slot />
    </main>
  </div>
</template>

<style>
/* 基本樣式重設 */
body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
  background-color: #f8f9fa;
  color: #333;
}

.app-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.app-header {
  background-color: #fff;
  border-bottom: 1px solid #e9ecef;
  padding: 0 2rem;
  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

.app-nav {
  display: flex;
  align-items: center;
  height: 60px;
  gap: 1.5rem;
}

.nav-link {
  text-decoration: none;
  color: #555;
  font-weight: 500;
  padding: 8px 12px;
  border-radius: 6px;
  transition: background-color 0.2s, color 0.2s;
}

.nav-link:hover {
  background-color: #f1f3f5;
}

/* 使用 .router-link-active class 來標示當前頁面 */
.nav-link.router-link-active {
  background-color: #007bff;
  color: #fff;
}

.app-main {
  flex: 1;
}

/* 讓頁面內容的 section 有一些基本的 padding */
section {
  max-width: 860px;
  margin: 32px auto;
  padding: 1rem;
  font-family: ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
}

/* 按鈕樣式美化 */
button {
  background-color: #007bff;
  color: white;
  border: none;
  padding: 10px 14px;
  border-radius: 8px;
  cursor: pointer;
  font-size: 1rem;
  transition: background-color 0.2s, box-shadow 0.2s;
}

button:hover {
  background-color: #0056b3;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

button:disabled {
  background-color: #cdd5de;
  cursor: not-allowed;
  box-shadow: none;
}

/* 輸入框樣式 */
input {
  padding: 10px 12px;
  border: 1px solid #ddd;
  border-radius: 8px;
  font-size: 1rem;
  transition: border-color 0.2s, box-shadow 0.2s;
}

input:focus {
  outline: none;
  border-color: #007bff;
  box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
}
</style>
