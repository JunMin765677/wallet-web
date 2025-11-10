<template>
  <Teleport to="body">
    <Transition
      enter-active-class="transition-opacity duration-300 ease-out"
      enter-from-class="opacity-0"
      enter-to-class="opacity-100"
      leave-active-class="transition-opacity duration-200 ease-in"
      leave-from-class="opacity-100"
      leave-to-class="opacity-0"
    >
      <div 
        v-if="show" 
        class="fixed inset-0 z-50 flex items-center justify-center bg-gray-900/70 p-4"
        @click="emit('close')"
        role="dialog" 
        aria-modal="true"
        :aria-labelledby="'modal-title-' + person?.personId"
      >
        <Transition
          enter-active-class="transition-all duration-300 ease-out"
          enter-from-class="opacity-0 scale-95"
          enter-to-class="opacity-100 scale-100"
          leave-active-class="transition-all duration-200 ease-in"
          leave-from-class="opacity-100 scale-100"
          leave-to-class="opacity-0 scale-95"
        >
          <div 
            v-if="show" 
            class="flex w-full max-w-2xl flex-col overflow-hidden rounded-xl bg-white shadow-2xl max-h-[65vh]" 
            @click.stop
          >
            <header class="flex items-center justify-between border-b border-gray-200 p-5">
              <h2 
                :id="'modal-title-' + person?.personId" 
                class="text-lg font-semibold text-gray-900"
              >
                {{ person?.name }} 的詳細資料
              </h2>
              <button
                @click="emit('close')"
                class="rounded-full p-1 text-gray-400 transition-colors hover:bg-gray-100 hover:text-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500"
                aria-label="關閉"
              >
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="h-6 w-6">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </header>

            <div v-if="person" class="flex-1 space-y-6 overflow-y-auto p-6">
              
              <section>
                <h3 class="mb-3 text-base font-semibold text-gray-800">個人資訊</h3>
                <dl class="grid grid-cols-1 gap-x-4 gap-y-3 sm:grid-cols-3">
                  <dt class="text-sm font-medium text-gray-500">系統 ID (Person)</dt>
                  <dd class="font-mono text-sm text-gray-900 sm:col-span-2">{{ person.personId }}</dd>
                  
                  <dt class="text-sm font-medium text-gray-500">個人 ID (KAGay)</dt>
                  <dd class="font-mono text-sm text-gray-900 sm:col-span-2">{{ person.personalId }}</dd>
                  
                  <dt class="text-sm font-medium text-gray-500">身分證號</dt>
                  <dd class="font-mono text-sm text-gray-900 sm:col-span-2">{{ person.nationalId || 'N/A' }}</dd>
                  
                  <dt class="text-sm font-medium text-gray-500">生日</dt>
                  <dd class="text-sm text-gray-900 sm:col-span-2">{{ formatDate(person.dateOfBirth) }}</dd>
                  
                  <dt class="text-sm font-medium text-gray-500">電話</dt>
                  <dd class="font-mono text-sm text-gray-900 sm:col-span-2">{{ person.phoneNumber || 'N/A' }}</dd>
                  
                  <dt class="text-sm font-medium text-gray-500">地址</dt>
                  <dd class="text-sm text-gray-900 sm:col-span-2">{{ (person.county || '') + (person.district || '') + (person.address || '') }}</dd>
                </dl>
              </section>

              <section>
                <h3 class="mb-3 text-base font-semibold text-gray-800">緊急聯絡人</h3>
                <dl class="grid grid-cols-1 gap-x-4 gap-y-3 sm:grid-cols-3">
                  <dt class="text-sm font-medium text-gray-500">姓名</dt>
                  <dd class="text-sm text-gray-900 sm:col-span-2">{{ person.emergencyContactName || 'N/A' }}</dd>
                  
                  <dt class="text-sm font-medium text-gray-500">關係</dt>
                  <dd class="text-sm text-gray-900 sm:col-span-2">{{ person.emergencyContactRelationship || 'N/A' }}</dd>
                  
                  <dt class="text-sm font-medium text-gray-500">電話</dt>
                  <dd class="font-mono text-sm text-gray-900 sm:col-span-2">{{ person.emergencyContactPhone || 'N/A' }}</dd>
                </dl>
              </section>

              <section>
                <h3 class="mb-3 text-base font-semibold text-gray-800">審核資訊</h3>
                <dl class="grid grid-cols-1 gap-x-4 gap-y-3 sm:grid-cols-3">
                  <dt class="text-sm font-medium text-gray-500">審核機關</dt>
                  <dd class="text-sm text-gray-900 sm:col-span-2">{{ person.reviewingAuthority || 'N/A' }}</dd>
                  
                  <dt class="text-sm font-medium text-gray-500">審核人員</dt>
                  <dd class="text-sm text-gray-900 sm:col-span-2">{{ person.reviewerName || 'N/A' }}</dd>
                  
                  <dt class="text-sm font-medium text-gray-500">聯絡電話</dt>
                  <dd class="font-mono text-sm text-gray-900 sm:col-span-2">{{ person.reviewerPhone || 'N/A' }}</dd>
                </dl>
              </section>

              <section>
                <h3 class="mb-3 text-base font-semibold text-gray-800">資格與資產</h3>
                
                <dl class="grid grid-cols-1 gap-x-4 gap-y-3 sm:grid-cols-3">
                  <dt class="text-sm font-medium text-gray-500">資格生效日</dt>
                  <dd class="text-sm text-gray-900 sm:col-span-2">{{ formatDate(person.eligibilityStartDate) }}</dd>

                  <dt class="text-sm font-medium text-gray-500">資格到期日</dt>
                  <dd class="text-sm text-gray-900 sm:col-span-2">{{ formatDate(person.eligibilityEndDate) }}</dd>
                </dl>

                <h4 class="mb-2 mt-4 text-sm font-semibold text-gray-700">個人（年收／動產／不動產）</h4>
                <dl class="grid grid-cols-1 gap-x-4 gap-y-3 sm:grid-cols-3">
                  <dt class="text-sm font-medium text-gray-500">個人年收入</dt>
                  <dd class="font-mono text-sm text-gray-900 sm:col-span-2">{{ formatCurrency(person.personalAnnualIncome) }}</dd>
                  
                  <dt class="text-sm font-medium text-gray-500">個人動產</dt>
                  <dd class="font-mono text-sm text-gray-900 sm:col-span-2">{{ formatCurrency(person.personalMovableAssets) }}</dd>
                  
                  <dt class="text-sm font-medium text-gray-500">個人不動產</dt>
                  <dd class="font-mono text-sm text-gray-900 sm:col-span-2">{{ formatCurrency(person.personalRealEstateAssets) }}</dd>
                </dl>

                <h4 class="mb-2 mt-4 text-sm font-semibold text-gray-700">家庭（年收／動產／不動產）</h4>
                <dl class="grid grid-cols-1 gap-x-4 gap-y-3 sm:grid-cols-3">
                  <dt class="text-sm font-medium text-gray-500">家庭年收入</dt>
                  <dd class="font-mono text-sm text-gray-900 sm:col-span-2">{{ formatCurrency(person.familyAnnualIncome) }}</dd>
                  
                  <dt class="text-sm font-medium text-gray-500">家庭動產</dt>
                  <dd class="font-mono text-sm text-gray-900 sm:col-span-2">{{ formatCurrency(person.familyMovableAssets) }}</dd>
                  
                  <dt class="text-sm font-medium text-gray-500">家庭不動產</dt>
                  <dd class="font-mono text-sm text-gray-900 sm:col-span-2">{{ formatCurrency(person.familyRealEstateAssets) }}</dd>
                </dl>
              </section>

            </div>

            <footer class="flex justify-end space-x-3 border-t border-gray-200 bg-gray-50 p-4">
              <button
                @click="emit('close')"
                class="rounded-md border border-gray-300 bg-white px-4 py-2 text-sm font-medium text-gray-700 shadow-sm transition-colors hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
              >
                關閉
              </button>
            </footer>
          </div>
        </Transition>
      </div>
    </Transition>
  </Teleport>
</template>

<script setup lang="ts">
// --- <script> 區塊的內容完全不變 ---

interface Person {
  personId: string;
  name: string;
  personalId: string;
  nationalId: string | null;
  county: string | null;
  district: string | null;
  address: string | null;
  phoneNumber: string | null;
  dateOfBirth: string | null;
  emergencyContactName: string | null;
  emergencyContactRelationship: string | null;
  emergencyContactPhone: string | null;
  reviewingAuthority: string | null;
  reviewerName: string | null;
  reviewerPhone: string | null;
  eligibilityStartDate: string | null;
  eligibilityEndDate: string | null;
  personalAnnualIncome: string | null;
  personalMovableAssets: string | null;
  personalRealEstateAssets: string | null;
  familyAnnualIncome: string | null;
  familyMovableAssets: string | null;
  familyRealEstateAssets: string | null;
  issuedVc: any | null;
}

defineProps<{ show: boolean; person: Person | null }>();
const emit = defineEmits<{ (e: 'close'): void }>();

function formatDate(dateString: string | null) {
  if (!dateString) return 'N/A';
  try {
    return new Date(dateString).toLocaleDateString('zh-TW', {
      year: 'numeric', month: '2-digit', day: '2-digit'
    });
  } catch { return '無效日期'; }
}

function formatCurrency(value: string | null) {
  if (value === null || value === undefined) return 'N/A';
  const num = parseInt(value, 10);
  if (Number.isNaN(num)) return 'N/A';
  // 為了保持 "N/A" 的對齊，我們可以在非 N/A 值前加上 $
  return `$ ${num.toLocaleString()}`;
}
</script>