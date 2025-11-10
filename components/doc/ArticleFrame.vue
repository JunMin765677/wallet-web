<!-- components/doc/ArticleFrame.vue -->
<script setup lang="ts">
defineProps<{
  title: string
  subtitle?: string
  breadcrumb?: { label: string; to: string }[]
}>()
</script>

<template>
  <article class="article-frame">
    <nav v-if="breadcrumb?.length" class="breadcrumb" aria-label="Breadcrumb">
      <ul>
        <li v-for="(b, i) in breadcrumb" :key="i">
          <NuxtLink :to="b.to">{{ b.label }}</NuxtLink>
        </li>
        <li aria-current="page">{{ title }}</li>
      </ul>
    </nav>

    <header class="header">
      <h1 class="title">
        <span class="icon" aria-hidden="true">
          <svg viewBox="0 0 24 24" width="22" height="22" fill="currentColor">
            <path d="M4 3h12a3 3 0 013 3v13a2 2 0 01-2 2H6a2 2 0 01-2-2V3zM8 7h8v2H8zM8 11h8v2H8zM8 15h8v2H8z"/>
          </svg>
        </span>
        {{ title }}
      </h1>
      <p v-if="subtitle" class="subtitle">{{ subtitle }}</p>
      <div class="actions">
        <NuxtLink to="/docs" class="back-link" aria-label="返回文件中心">
          ← 返回文件中心
        </NuxtLink>
      </div>
    </header>

    <section class="content">
      <slot />
    </section>
  </article>
</template>

<style scoped>
.article-frame {
  background: #fff;
  border: 1px solid #e0dcd7;
  border-radius: 14px;
  padding: 1.25rem 1.5rem;
  box-shadow: 0 4px 10px rgba(0,0,0,.05);
}

/* 麵包屑 */
.breadcrumb ul {
  list-style: none;
  padding: 0;
  margin: 0 0 .5rem;
  display: flex;
  gap: .5rem;
  flex-wrap: wrap;
  font-size: .9rem;
}
.breadcrumb a {
  color: #8b6a56;
  text-decoration: none;
}
.breadcrumb li+li::before {
  content: "/";
  margin: 0 .25rem;
  color: #b9aea7;
}

/* 標題區 */
.header {
  margin-bottom: .75rem;
}
.title {
  display: flex;
  align-items: center;
  gap: .5rem;
  margin: 0;
  font-size: 1.4rem;
  color: #c96c3b;
}
.subtitle {
  margin: .35rem 0 0;
  color: #5a4e47;
}

/* 操作按鈕 */
.actions {
  margin-top: .5rem;
}
.back-link {
  display: inline-block;
  padding: .35rem .6rem;
  border-radius: 8px;
  border: 1px solid #e0dcd7;
  background: #fff;
  color: #5a4e47;
  text-decoration: none;
}
.back-link:hover {
  border-color: #d27b4b33;
  box-shadow: 0 6px 14px rgba(210,123,75,.12);
  transform: translateY(-1px);
  transition: all .2s ease;
}

/* 內容插槽 */
.content {
  margin-top: .75rem;
}

/* * RWD 設定
 * 當螢幕寬度小於等於 768px 時套用
 */
@media (max-width: 768px) {
  .article-frame {
    /* 縮小卡片內部 padding */
    padding: 1rem;
  }
  .breadcrumb ul {
    /* 縮小麵包屑字體 */
    font-size: .85rem;
  }
  .title {
    /* 縮小主標題 */
    font-size: 1.25rem;
    gap: .4rem;
  }
  .subtitle {
    /* 縮小副標題 */
    font-size: .95rem;
    margin-top: .25rem;
  }
  .actions {
    margin-top: .75rem; /* 讓按鈕與標題間距稍大一點 */
  }
  .back-link {
    /* 讓返回按鈕在手機上更容易點擊 */
    padding: .4rem .7rem;
    font-size: .95rem;
  }
}
</style>