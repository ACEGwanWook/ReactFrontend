/**
 * Sidebar.jsx
 * Sidebar.jsp + sidebar.js 완전 재현
 * - 서브메뉴 토글 (∨/∧ 클릭)
 * - 모바일 반응형 (640px 이하 숨김 + 햄버거)
 * - active 링크 강조
 */
import { useState, useEffect } from 'react'
import { NavLink, useLocation } from 'react-router-dom'

const MENUS = [
  {
    title: '기준 정보 관리',
    items: [
      { label: '1)공동코드관리', to: '/CommonCode' },
      { label: '2)사용자 관리', to: '/RobotResource' },
    ]
  },
  {
    title: '자동화 장비 자산 관리',
    items: [
      { label: '1)자동화 장비 자산 관리', to: '/AutoAsset' },
      { label: '2)자동화 장비 유지 보수 이력 관리', to: '/Maintenance' },
    ]
  },
  {
    title: '인공지능 데이터 관리',
    items: [
      { label: '1)설계 정보 관리', to: '/DesignInfo' },
      { label: '2)Row Data 관리', to: '/IOTData' },
      { label: '3)용접 품질진단 모델', to: '/QualityModel' },
      { label: '4)상황인지 모델 데이터', to: '/SituationDataModel' },
      { label: '5)비정형 데이터 관리', to: '/IrRegularData' },
      { label: '6)용접 제조 데이터셋 관리', to: '/WeldDataset' },
    ]
  },
  {
    title: '생산 상세 모니터링',
    items: [
      { label: '1)용접로봇 실시간 모니터링', to: '/AutoSitutation' },
      { label: '2)용접 로봇 공정 모니터링', to: '/ProductSituation' },
      { label: '3)용접 공정 전체 모니터링', to: '/RobotLine' },
      { label: '4)블록별 상세 공정 모니터링', to: '/BlockMonitering' },
    ]
  },
  {
    title: '통합 생산 관리',
    items: [
      { label: '1)용접 공정 생산 실행 계획 관리', to: '/WorkOrder' },
      { label: '2)용접 로봇/휴먼 배원 관리', to: '/RobotOrder' },
      { label: '3)Bay 별 배치 및 생산 관리', to: '/DispatchWip' },
    ]
  },
  {
    title: '정보 연계',
    items: [
      { label: '1)협동로봇 기반 AI 통합 운영 플랫폼', to: '#' },
    ]
  },
]

export default function Sidebar() {
  const location = useLocation()

  // 각 그룹 열림/닫힘 — 기본값 false (∨ 닫힌 상태)
  const [open, setOpen] = useState(MENUS.map(() => false))

  // 모바일 반응형 — sidebar.js의 mobilewidth() 대체
  const [navVisible, setNavVisible] = useState(true)
  const [isMobile, setIsMobile]   = useState(false)

  useEffect(() => {
    function check() {
      const mobile = window.matchMedia('screen and (max-width: 640px)').matches
      setIsMobile(mobile)
      if (mobile) setNavVisible(false)
      else setNavVisible(true)
    }
    check()
    window.addEventListener('resize', check)
    return () => window.removeEventListener('resize', check)
  }, [])

  function toggle(idx) {
    setOpen(prev => prev.map((v, i) => i === idx ? !v : v))
  }

  return (
    <div className="sidebar">
      <NavLink to="/"><img className="logo" src="/images/미포.jpg" alt="로고" /></NavLink>

      {/* 모바일 햄버거 — sidebar.js의 .navbar-toggler 대체 */}
      {isMobile && (
        <input
          type="checkbox"
          title="Navigation menu"
          className="navbar-toggler"
          checked={navVisible}
          onChange={e => setNavVisible(e.target.checked)}
        />
      )}

      <nav className={navVisible ? 'flex-column' : 'navhide'}>
        {MENUS.map((menu, idx) => (
          <div key={idx}>
            {/* firstmenu 클릭 → 서브메뉴 토글 */}
            <div
              className="firstmenu"
              onClick={() => toggle(idx)}
              style={{ cursor: 'pointer' }}
            >
              <div className="nav-link">{menu.title} &nbsp;</div>
              <span className="isopen" aria-hidden="true">
                {open[idx] ? '∨' : '∧'}
              </span>
            </div>

            {/* 서브메뉴 — open[idx]가 false면 display:none */}
            <ul
              className="submenu flex-column"
              style={{ display: open[idx] ? 'flex' : 'none' }}
            >
              {menu.items.map((item) => (
                <NavLink
                  key={item.to}
                  to={item.to}
                  className={({ isActive }) => isActive ? 'active-nav' : ''}
                >
                  {item.label}
                </NavLink>
              ))}
            </ul>
          </div>
        ))}
      </nav>
    </div>
  )
}
