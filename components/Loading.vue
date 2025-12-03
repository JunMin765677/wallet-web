<script setup>
import { onMounted, onBeforeUnmount, ref } from 'vue'

let uidCounter = 0

function generateSecureUid(): string {
  // 優先使用 Web Crypto / Node Crypto 的 CSPRNG
  const g = globalThis as any
  if (g && g.crypto && typeof g.crypto.getRandomValues === 'function') {
    const bytes = new Uint8Array(16)
    g.crypto.getRandomValues(bytes)
    return Array.from(bytes, b => b.toString(16).padStart(2, '0')).join('')
  }

  // 後備方案：時間戳 + 遞增計數，避免使用 Math.random()
  const nowHex = Date.now().toString(16)
  const counterHex = (++uidCounter).toString(16)
  return nowHex + counterHex
}

// ========== Props ==========
const props = defineProps({
  phrases: {
    type: Array,
    default: () => [
      'Feeding unicorns',
      'Grabbing tasks',
      'Collating conversations',
      'Reticulating splines',
      'Pondering emptiness',
      'Considering alternatives',
      'Shuffling bits',
      'Celebrating moments',
      'Generating phrases',
      'Simulating workflow',
      'Empowering humanity',
      'Being aspirational',
      'Doing the hokey pokey',
      'Bueller',
      'Cracking jokes',
      'Slacking off'
    ]
  },
  verticalSpacing: { type: Number, default: 50 },
  scrollBaseSpeed: { type: Number, default: 0.8 },
  easePeriod: { type: Number, default: 260 },
  visibleHeight: { type: Number, default: 150 },
  bottomPadding: { type: Number, default: 30 },
  tailHoldMs: { type: Number, default: 150 },

  // 🎨 顏色控制 (保持原始設定)
  checkIdleColor: { type: String, default: '#ffffff' },
  checkActiveColor: { type: String, default: '#ff6d92' },
  circleFillColor: { type: String, default: '#ffffff' },
  circleFillMaxAlpha: { type: Number, default: 0.9 }
})

const emit = defineEmits(['done'])

// ==== iOS/SVG 相容：所有 <defs> 內元素與動態注入的標籤，ID 都帶唯一前綴 ====
const uid = generateSecureUid()
const phrasesGroupId = `phrases-${uid}`
const maskId = `mask-${uid}`
const gradId = `linearGradient-${uid}`
const checkmarkIdPrefix = `loadingCheckSVG-${uid}-`
const checkmarkCircleIdPrefix = `loadingCheckCircleSVG-${uid}-`

// 直接用 ref 取得 <g id="phrases-...">，避免行動端 DOM 時機問題
const phrasesGroupRef = ref(null)

// ========== Helpers ==========
function createSVG(tag, properties = {}, children) {
  const el = document.createElementNS('http://www.w3.org/2000/svg', tag)
  for (const prop in properties) el.setAttribute(prop, properties[prop])
  if (children && children.length) children.forEach(c => el.appendChild(c))
  return el
}

function createPhraseSvg(phrase, yOffset) {
  const text = createSVG('text', {
    fill: 'white', // 保持原始設定
    x: 50,
    y: yOffset,
    'font-size': 18,
    'font-family': 'system-ui, -apple-system, Segoe UI, Roboto, Arial',
    'dominant-baseline': 'middle',
    'paint-order': 'stroke',
    'stroke': 'transparent',
    'stroke-width': 0
  })
  text.appendChild(document.createTextNode(`${phrase}...`))
  return text
}

function createCheckSvg(yOffset, index) {
  const check = createSVG('polygon', {
    points:
      '21.661,7.643 13.396,19.328 9.429,15.361 7.075,17.714 13.745,24.384 24.345,9.708',
    fill: 'rgba(255,255,255,1)', // 保持原始設定
    id: checkmarkIdPrefix + index
  })
  const circleOutline = createSVG('path', {
    d: 'M16,0C7.163,0,0,7.163,0,16s7.163,16,16,16s16-7.163,16-16S24.837,0,16,0z M16,30C8.28,30,2,23.72,2,16C2,8.28,8.28,2,16,2 c7.72,0,14,6.28,14,14C30,23.72,23.72,30,16,30z',
    fill: 'white' // 保持原始設定
  })
  const circle = createSVG('circle', {
    id: checkmarkCircleIdPrefix + index,
    fill: 'rgba(255,255,255,0)',
    cx: 16,
    cy: 16,
    r: 15
  })
  return createSVG(
    'g',
    { transform: `translate(10 ${yOffset - 20}) scale(.9)` },
    [circle, check, circleOutline]
  )
}

function addPhrasesToDocument(target, items, spacing) {
  items.forEach((phrase, index) => {
    const yOffset = 30 + spacing * index
    target.appendChild(createPhraseSvg(phrase, yOffset))
    target.appendChild(createCheckSvg(yOffset, index))
  })
}

function easeInOut(t, period) {
  return (Math.sin(t / period + 100) + 1) / 2
}

// 顏色工具
function hexToRgb(hex) {
  const m = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)
  if (!m) return { r: 255, g: 255, b: 255 }
  return {
    r: parseInt(m[1], 16),
    g: parseInt(m[2], 16),
    b: parseInt(m[3], 16)
  }
}
function lerp(a, b, t) {
  return a + (b - a) * t
}
function mixRgb(c1, c2, t) {
  return {
    r: Math.round(lerp(c1.r, c2.r, t)),
    g: Math.round(lerp(c1.g, c2.g, t)),
    b: Math.round(lerp(c1.b, c2.b, t))
  }
}

// ========== Animation ==========
let rafId = null

onMounted(() => {
  const groupEl =
    phrasesGroupRef.value || document.getElementById(phrasesGroupId)
  if (!groupEl) return

  // 建立清單
  const items = [...props.phrases]
  addPhrasesToDocument(groupEl, items, props.verticalSpacing)

  // 收集 check 與圈圈
  const checks = items
    .map((_, i) => ({
      check: document.getElementById(checkmarkIdPrefix + i),
      circle: document.getElementById(checkmarkCircleIdPrefix + i)
    }))
    .filter(p => p.check && p.circle)

  // 捲動邏輯
  let currentY = 0
  const yLast = 30 + props.verticalSpacing * (items.length - 1)
  const endY = -(yLast - (props.visibleHeight - props.bottomPadding))

  const idle = hexToRgb(props.checkIdleColor)
  const active = hexToRgb(props.checkActiveColor)
  const circleBase = hexToRgb(props.circleFillColor)

  function animate() {
    const now = Date.now()
    currentY -= props.scrollBaseSpeed * easeInOut(now, props.easePeriod)
    groupEl.setAttribute('transform', `translate(0 ${currentY})`)

    checks.forEach((pair, i) => {
      const boundary = -i * props.verticalSpacing + props.verticalSpacing + 15
      if (currentY < boundary) {
        const alpha = Math.max(
          Math.min(1 - (currentY - boundary + 15) / 30, 1),
          0
        )
        const circleA = Math.min(alpha, props.circleFillMaxAlpha)

        pair.circle.setAttribute(
          'fill',
          `rgba(${circleBase.r}, ${circleBase.g}, ${circleBase.b}, ${circleA})`
        )

        const c = mixRgb(idle, active, alpha)
        pair.check.setAttribute('fill', `rgb(${c.r}, ${c.g}, ${c.b})`)
      }
    })

    if (currentY <= endY) {
      cancelAnimationFrame(rafId)
      rafId = null
      setTimeout(() => emit('done'), props.tailHoldMs)
      return
    }
    rafId = requestAnimationFrame(animate)
  }

  rafId = requestAnimationFrame(animate)
})

onBeforeUnmount(() => {
  if (rafId) cancelAnimationFrame(rafId)
  rafId = null
})
</script>

<template>
  <div id="page">
    <div id="phrase_box">
      <svg
        width="100%"
        height="100%"
        viewBox="0 0 260 150"
        preserveAspectRatio="xMidYMid meet"
        role="img"
        aria-label="Loading phrases"
      >
        <defs>
          <mask :id="maskId" maskUnits="userSpaceOnUse" maskContentUnits="userSpaceOnUse">
            <linearGradient :id="gradId" gradientUnits="objectBoundingBox" x2="0" y2="1">
              <stop stop-color="white" stop-opacity="0" offset="0%" />
              <stop stop-color="white" stop-opacity="1" offset="30%" />
              <stop stop-color="white" stop-opacity="1" offset="70%" />
              <stop stop-color="white" stop-opacity="0" offset="100%" />
            </linearGradient>
            <rect width="100%" height="100%" :fill="`url(#${gradId})`" />
          </mask>
        </defs>

        <g width="100%" height="100%" :mask="`url(#${maskId})`">
          <g :id="phrasesGroupId" ref="phrasesGroupRef"></g>
        </g>
      </svg>
    </div>

    <div id="footer">
      <div id="logo"></div>暖心e證通
    </div>
  </div>
</template>

<style lang="scss" scoped>
@use "sass:color";

// 柔和低飽和配色（可自行調整）
$gold: #c5b892;        // fog gold
$coral: #8fa39d;       // sage green
$brightCoral: #b7c6be; // mist grey

#page {
  $opacity: 90%;
  align-items: center;
  background: linear-gradient(
    to top right,
    color.mix($coral, white, $opacity) 10%,
    color.mix($brightCoral, white, $opacity) 65%,
    color.mix($gold, white, $opacity) 125%
  );
  /* position: absolute; */ // <-- 移除
  /* inset: 0; */ // <-- 移除
  display: flex;
  flex-direction: column; // <-- 新增
  justify-content: center;
  transition: opacity 1s;

  // --- 新增卡片樣式 ---
  padding: 24px;
  border-radius: 12px;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
  min-width: calc(260px + 48px); // phrase_box 寬度 + 兩邊 padding
  
  // --- 新增上下外距 ---
  margin-top: 20px;
  margin-bottom: 20px;
}

#phrase_box {
  display: flex;
  flex-flow: column;
  height: 150px;
  width: 260px;
  overflow: hidden;
}

#footer {
  /* bottom: 30px; */ // <-- 移除
  color: white; // <-- 保留
  display: flex;
  justify-content: center;
  /* left: 0; */ // <-- 移除
  /* position: fixed; */ // <-- 移除
  /* right: 0; */ // <-- 移除
  margin-top: 20px; // <-- 新增
}
</style>