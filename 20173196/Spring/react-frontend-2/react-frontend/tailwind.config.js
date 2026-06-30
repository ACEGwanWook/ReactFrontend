/** @type {import('tailwindcss').Config} */
/* ================================================================
   HD현대미포 · 용접 로봇 AI 운영 플랫폼  —  tailwind.config.js
   기존 style.css의 CSS 변수 토큰을 Tailwind 테마에 1:1 매핑
   ================================================================ */

module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}",
    "./public/index.html",
  ],

  /* ── Preflight 비활성화 ─────────────────────────────────────────
     기존 style.css의 button / input / table 전역 스타일 보존.
     Tailwind의 base reset이 덮어쓰지 않도록 반드시 false.
     ─────────────────────────────────────────────────────────────── */
  corePlugins: {
    preflight: false,
  },

  theme: {
    extend: {
      /* ── 색상 토큰 ─────────────────────────────────────────────── */
      colors: {
        /* 배경 계층 */
        'c-bg':     '#0d1117',
        'c-surf':   '#161b22',
        'c-panel':  '#1c2330',
        'c-hover':  '#21293a',
        'c-active': '#243047',

        /* 테두리 */
        'c-bdr':    '#2d3748',
        'c-bdr-l':  '#3d4f6a',

        /* 포인트 컬러 */
        'c-acc':    '#2f80ed',
        'c-acc-s':  '#1d4ed8',

        /* 텍스트 */
        'c-tp':     '#ffffff',
        'c-ts':     '#8b949e',
        'c-tm':     '#4d5966',
        'c-info':   '#aad4f5',

        /* 상태 */
        'c-ok':     '#3fb950',
        'c-warn':   '#d29922',
        'c-err':    '#f85149',
      },

      /* ── 폰트 패밀리 ───────────────────────────────────────────── */
      fontFamily: {
        sans: ["'Pretendard'", "'Noto Sans KR'", "'Segoe UI'", 'system-ui', 'sans-serif'],
        mono: ["'JetBrains Mono'", "'Fira Code'", 'monospace'],
      },

      /* ── 그림자 ────────────────────────────────────────────────── */
      boxShadow: {
        'card':   '0 2px 12px rgba(0,0,0,0.45), 0 1px 3px rgba(0,0,0,0.3)',
        'card-lg':'0 4px 24px rgba(0,0,0,0.55), 0 2px 8px rgba(0,0,0,0.35)',
        'acc':    '0 0 0 3px rgba(47,128,237,0.25)',
        'ok':     '0 0 8px rgba(63,185,80,0.4)',
        'err':    '0 0 8px rgba(248,81,73,0.4)',
        'warn':   '0 0 8px rgba(210,153,34,0.4)',
        'inset':  'inset 0 1px 0 rgba(255,255,255,0.04)',
        'modal':  '0 8px 40px rgba(0,0,0,0.7)',
      },

      /* ── 테두리 반경 ───────────────────────────────────────────── */
      borderRadius: {
        'sm':  '4px',
        'md':  '6px',
        'lg':  '10px',
        'xl':  '14px',
        '2xl': '18px',
      },

      /* ── 애니메이션 ────────────────────────────────────────────── */
      keyframes: {
        'fade-in': {
          '0%':   { opacity: '0', transform: 'translateY(4px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
        'pulse-ok': {
          '0%, 100%': { boxShadow: '0 0 0 0 rgba(63,185,80,0.4)' },
          '50%':      { boxShadow: '0 0 0 5px rgba(63,185,80,0)' },
        },
        'pulse-err': {
          '0%, 100%': { boxShadow: '0 0 0 0 rgba(248,81,73,0.4)' },
          '50%':      { boxShadow: '0 0 0 5px rgba(248,81,73,0)' },
        },
        'shimmer': {
          '0%':   { backgroundPosition: '-400px 0' },
          '100%': { backgroundPosition: '400px 0' },
        },
        'slide-in-right': {
          '0%':   { transform: 'translateX(100%)', opacity: '0' },
          '100%': { transform: 'translateX(0)',    opacity: '1' },
        },
        'gauge-fill': {
          '0%':   { width: '0%' },
          '100%': { width: 'var(--gauge-width, 50%)' },
        },
      },
      animation: {
        'fade-in':        'fade-in 0.2s ease-out',
        'pulse-ok':       'pulse-ok 2s ease-in-out infinite',
        'pulse-err':      'pulse-err 1.5s ease-in-out infinite',
        'shimmer':        'shimmer 1.5s linear infinite',
        'slide-in-right': 'slide-in-right 0.25s cubic-bezier(0.16,1,0.3,1)',
        'gauge-fill':     'gauge-fill 0.8s cubic-bezier(0.4,0,0.2,1) forwards',
      },

      /* ── 간격 보완 ─────────────────────────────────────────────── */
      spacing: {
        'sidebar': '250px',
      },

      /* ── z-index ───────────────────────────────────────────────── */
      zIndex: {
        'sidebar': '100',
        'tabs':    '10',
        'modal':   '20',
        'tooltip': '50',
      },
    },
  },

  plugins: [],
};
