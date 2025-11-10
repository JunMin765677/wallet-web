<template>
  <div class="batch-results-container">
    <h3 class="data-title">
      即時驗證結果 ({{ results.length }})
    </h3>
    
    <div v-if="results.length === 0" class="empty-state">
      <p>尚未有任何驗證結果...</p>
    </div>

    <ul v-else class="results-list">
      <li 
        v-for="result in [...results].reverse()" 
        :key="result.logId" 
        class="result-list-item"
      >
        <div 
          class="result-item" 
          :class="[
            getStatusClass(result.status), 
            { 'is-expandable': result.status === 'success' },
            { 'is-expanded': expandedLogId === result.logId }
          ]"
          @click="toggleDetails(result)"
        >
          <span class="result-icon">{{ getStatusIcon(result.status) }}</span>
          
          <div class="result-info">
            <span class="result-name">{{ getResultName(result) }}</span>
            <span class="result-message">{{ getResultMessage(result) }}</span>
          </div>
          
          <span v-if="result.status === 'success'" class="expand-indicator">
            {{ expandedLogId === result.logId ? '▴ 收合' : '▾ 詳細' }}
          </span>
        </div>

        <div 
          v-if="result.status === 'success' && expandedLogId === result.logId" 
          class="detail-view-wrapper"
        >
          <VerificationResultDetail :verificationData="result.verificationData" />
        </div>

      </li>
    </ul>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
// [⭐️ NEW] 1. 匯入新元件
import VerificationResultDetail from '~/components/VerificationResultDetail.vue';

// (Props 不變)
defineProps<{
  results: any[]
}>();

// [⭐️ NEW] 2. 追蹤哪個項目被展開
const expandedLogId = ref<number | null>(null);

// [⭐️ NEW] 3. 點擊切換函式
function toggleDetails(result: any) {
  // 只有 "success" 狀態的項目可以展開
  if (result.status !== 'success') {
    return;
  }
  
  // 如果點擊的是已經展開的項目，則關閉
  if (expandedLogId.value === result.logId) {
    expandedLogId.value = null;
  } else {
    // 否則，展開此項目
    expandedLogId.value = result.logId;
  }
}


// --- 輔助函式 (不變) ---

function getStatusClass(status: string) {
  switch (status) {
    case 'success': return 'success';
    case 'failed':
    case 'expired':
    case 'error_missing_uuid':
    case 'poll_error': return 'error';
    case 'initiated':
    default:
      return 'pending';
  }
}
function getStatusIcon(status: string) {
  switch (status) {
    case 'success': return '✅';
    case 'failed':
    case 'expired':
    case 'poll_error': return '❌';
    case 'error_missing_uuid': return '⚠️';
    case 'initiated':
    default:
      return '⏳';
  }
}
function getResultName(result: any): string {
  if (result.status === 'success' && result.verificationData?.person?.name) {
    const name = result.verificationData.person.name;
    return name.length > 0 ? `${name.charAt(0)}O${name.slice(2)}` : '驗證成功';
  }
  if (result.status === 'error_missing_uuid' && result.data?.data?.[0]?.claims) {
     const nameClaim = result.data.data[0].claims.find((c: any) => c.ename === 'name');
     if (nameClaim) {
       const name = nameClaim.value;
       return name.length > 0 ? `${name.charAt(0)}O${name.slice(2)}` : '驗證異常';
     }
  }
  if (result.status === 'initiated') {
    return '驗證進行中...';
  }
  return "驗證失敗或過期";
}
function getResultMessage(result: any): string {
  if (result.message) {
    return result.message;
  }
  switch(result.status) {
    case 'success': return '驗證成功';
    case 'initiated': return '等待使用者回應...';
    default: return '狀態不明';
  }
}
</script>

<style lang="scss" scoped>
.batch-results-container {
  margin-top: 2rem;
}
.data-title {
  font-size: 1.125rem;
  font-weight: 600;
  color: #2d3748;
  padding-bottom: .5rem;
  border-bottom: 1px solid #e2e8f0;
  margin-bottom: 1rem;
}
.empty-state {
  text-align: center;
  padding: 2rem;
  font-size: .875rem;
  color: #718096;
  background-color: #f7fafc;
  border: 1px dashed #e2e8f0;
  border-radius: .5rem;
}

/* --- [⭐️ 修改] 列表樣式 --- */
.results-list {
  list-style-type: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 0.75rem; /* 調整 <li> 之間的間距 */
}

/* [NEW] <li> 容器 */
.result-list-item {
  /* 這個 <li> 本身沒有樣式，樣式在子層級 */
  transition: all 0.2s ease-in-out;
}

/* 摘要列 */
.result-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 0.75rem 1rem;
  border-radius: .5rem;
  border: 1px solid #e2e8f0;
  transition: all 0.2s ease-in-out;

  /* [NEW] 可點擊的樣式 */
  &.is-expandable {
    cursor: pointer;
    &:hover {
      border-color: #4299e1;
      background-color: #f7fafc;
    }
  }

  /* [NEW] 展開時，移除底部的圓角和邊框 */
  &.is-expanded {
    border-bottom-left-radius: 0;
    border-bottom-right-radius: 0;
    border-bottom-color: #f0f0f0;
  }

  &.success {
    background-color: #f0fff4;
    border-color: #9ae6b4;
    .result-name { color: #276749; }
  }
  &.error {
    background-color: #fff5f5;
    border-color: #fed7d7;
    .result-name { color: #9b2c2c; }
  }
  &.pending {
    background-color: #fffff0;
    border-color: #f6e05e;
    .result-name { color: #744210; }
  }
}

.result-icon {
  font-size: 1.25rem;
}
.result-info {
  flex-grow: 1;
}
.result-name {
  display: block;
  font-weight: 600;
  font-size: .875rem;
  color: #1a202c;
}
.result-message {
  display: block;
  font-size: .75rem;
  color: #718096;
}

/* [NEW] "詳細" 指示器 */
.expand-indicator {
  font-size: .75rem;
  font-weight: 600;
  color: #4299e1;
  flex-shrink: 0;
  margin-left: .5rem;
}

/* [NEW] 詳細資料的容器 */
.detail-view-wrapper {
  /* 接續 .result-item 的樣式 */
  padding: 1rem;
  background: #f7fafc;
  border: 1px solid #e2e8f0;
  border-top: none;
  border-radius: 0 0 .5rem .5rem;
}
</style>