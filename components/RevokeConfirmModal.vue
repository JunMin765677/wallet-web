<template>
  <Teleport to="body">
    <Transition name="modal-fade">
      <div v-if="show" class="modal-backdrop" @click="emit('close')">
        <div class="modal-content" @click.stop>
          
          <div class="modal-header">
            <h2 class="modal-title">確認註銷資格</h2>
            <button @click="emit('close')" class="close-button" :disabled="isLoading">
              &times;
            </button>
          </div>

          <div class="modal-body">
            
            <p class="confirm-text">
              您確定要註銷
              <strong class="text-red">{{ person?.name }}</strong>
              的
              <strong class="text-blue">{{ templateName }}</strong>
              資格嗎？
            </p>
            
            <p class="confirm-subtext">
              此操作將會：
            </p>
            <ul class="confirm-list">
              <li>永久移除此人的福利資格。</li>
              <li>註銷其 App 中已持有的數位憑證。</li>
              <li>此動作無法復原。</li>
            </ul>

            <div class="form-group">
              <label for="revoke-reason" class="form-label">
                註銷原因 (建議填寫，供稽核使用)
              </label>
              <textarea
                id="revoke-reason"
                v-model="revokeReason"
                class="form-textarea"
                rows="3"
                placeholder="例如：2025年度資格審核未通過"
              ></textarea>
            </div>
            
            <div v-if="errorMessage" class="error-box">
              <p class="error-title">註銷失敗</p>
              <p class="error-text">{{ errorMessage }}</p>
            </div>

          </div>

          <div class="modal-footer">
            <button @click="emit('close')" class="cancel-button" :disabled="isLoading">
              取消
            </button>
            <button 
              @click="handleConfirm" 
              class="revoke-button" 
              :disabled="isLoading"
            >
              <span v-if="isLoading">
                <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white inline" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                註銷中...
              </span>
              <span v-else>
                確認註銷
              </span>
            </button>
          </div>

        </div>
      </div>
    </Transition>
  </Teleport>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';

// (型別)
interface Person {
  personId: string;
  name: string;
}

// --- Props & Emits ---
const props = defineProps<{
  show: boolean;
  person: Person | null;
  templateName: string;
  isLoading: boolean; // 由父層級控制 API loading
  errorMessage: string | null; // 顯示父層級傳來的 API 錯誤
}>();

const emit = defineEmits<{
  (e: 'close'): void;
  (e: 'confirm-revoke', payload: { reason: string }): void;
}>();

// --- 內部狀態 ---
const revokeReason = ref('');

// --- 監聽 ---
// 當 Modal 重新開啟時，清空舊的註銷原因
watch(() => props.show, (newVal) => {
  if (newVal === true) {
    revokeReason.value = '';
  }
});

// --- 方法 ---
function handleConfirm() {
  // 將原因 emit 給父層級，由父層級呼叫 API
  emit('confirm-revoke', { reason: revokeReason.value });
}
</script>

<style lang="scss" scoped>
/* --- Modal 動畫 (與 PersonDetailModal 相同) --- */
.modal-fade-enter-active,
.modal-fade-leave-active {
  transition: opacity 0.3s ease;
}
.modal-fade-enter-from,
.modal-fade-leave-to {
  opacity: 0;
}

/* --- Modal 佈局 (與 PersonDetailModal 相同) --- */
.modal-backdrop {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  z-index: 50;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center; /* 垂直置中 */
  justify-content: center;
  padding: 1rem;
}

.modal-content {
  background-color: #ffffff;
  border-radius: .75rem;
  box-shadow: 0 25px 50px -12px rgba(0,0,0,.25);
  width: 100%;
  max-width: 32rem; /* 註銷 Modal 可以窄一點 */
  margin: 0 auto;
  display: flex;
  flex-direction: column;
}

/* Header */
.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 1.5rem;
  border-bottom: 1px solid #e2e8f0;
}
.modal-title {
  font-size: 1.25rem;
  font-weight: 700;
  color: #c53030; /* 標題紅色 */
}
.close-button {
  font-size: 2rem;
  font-weight: 300;
  color: #a0aec0;
  background: none;
  border: none;
  cursor: pointer;
  padding: 0;
  &:hover { color: #4a5568; }
}

/* Body */
.modal-body {
  padding: 1.5rem;
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}
.confirm-text {
  font-size: 1.125rem;
  color: #4a5568;
  line-height: 1.6;
  .text-red {
    font-weight: 700;
    color: #c53030;
  }
  .text-blue {
    font-weight: 700;
    color: #4299e1;
  }
}
.confirm-subtext {
  font-weight: 600;
  color: #4a5568;
}
.confirm-list {
  list-style-type: disc;
  padding-left: 1.25rem;
  font-size: .875rem;
  color: #718096;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  li::marker {
    color: #c53030;
  }
}

/* (共用) Form */
.form-group {
  margin-top: 0.5rem;
}
.form-label {
  display: block;
  font-size: .875rem;
  font-weight: 600;
  color: #4a5568;
  margin-bottom: .5rem;
}
.form-textarea {
  display: block;
  width: 100%;
  padding: .75rem 1rem;
  font-size: 1rem;
  color: #2d3748;
  background-color: #ffffff;
  border: 1px solid #cbd5e0;
  border-radius: .375rem;
  box-shadow: 0 1px 2px 0 rgba(0,0,0,.05);
  &:focus {
    outline: none;
    border-color: #4299e1;
    box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.5);
  }
}

/* (共用) Error Box */
.error-box {
  padding: .75rem;
  background-color: #fff5f5;
  border: 1px solid #fc8181;
  border-radius: .375rem;
  color: #c53030;
  .error-title { font-size: .875rem; font-weight: 600; }
  .error-text { font-size: .875rem; margin-top: .25rem; }
}


/* Footer */
.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: 0.75rem;
  padding: 1rem 1.5rem;
  background-color: #f7fafc;
  border-top: 1px solid #e2e8f0;
  border-bottom-left-radius: .75rem;
  border-bottom-right-radius: .75rem;
}
.cancel-button, .revoke-button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: .5rem 1rem;
  font-size: .875rem;
  font-weight: 600;
  border: none;
  border-radius: .375rem;
  transition: background-color .2s;
  cursor: pointer;
  
  &:disabled {
    opacity: .5;
    cursor: not-allowed;
  }
}
.cancel-button {
  color: #2d3748;
  background-color: #ffffff;
  border: 1px solid #cbd5e0;
  &:hover:not(:disabled) { background-color: #f7fafc; }
}
.revoke-button {
  color: #ffffff;
  background-color: #c53030; /* 紅色 */
  &:hover:not(:disabled) { background-color: #9b2c2c; }
}
</style>