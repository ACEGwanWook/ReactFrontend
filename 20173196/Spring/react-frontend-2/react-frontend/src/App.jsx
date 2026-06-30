/**
 * App.jsx
 * page.jsp + index.jsp 의 레이아웃 역할
 * Sidebar + 메인 콘텐츠 + 탭 시스템
 *
 * React Router v6의 <Outlet> 이 page.jsp의 <jsp:include page="${mainPage}"/> 를 대체
 */
import { useEffect, useRef, useState } from 'react'
import { Routes, Route, useLocation, Link } from 'react-router-dom'
import Sidebar from './components/Sidebar'
import SideModal from './components/SideModal'

// ── 페이지 컴포넌트 import ─────────────────────────────────
import IndexPage           from './pages/IndexPage'
import CommonCodePage      from './pages/CommonCodePage'
import RobotResourcePage   from './pages/RobotResourcePage'
import AutoAssetPage       from './pages/AutoAssetPage'
import MaintenancePage     from './pages/MaintenancePage'
import DesignInfoPage      from './pages/DesignInfoPage'
import IOTDataPage         from './pages/IOTDataPage'
import QualityModelPage    from './pages/QualityModelPage'
import SituationDataModelPage from './pages/SituationDataModelPage'
import IrRegularDataPage   from './pages/IrRegularDataPage'
import WeldDatasetPage     from './pages/WeldDatasetPage'
import AutoSitutationPage  from './pages/AutoSitutationPage'
import ProductSituationPage from './pages/ProductSituationPage'
import RobotLinePage       from './pages/RobotLinePage'
import BlockMoniteringPage from './pages/BlockMoniteringPage'
import WorkOrderPage       from './pages/WorkOrderPage'
import RobotOrderPage      from './pages/RobotOrderPage'
import DispatchWipPage     from './pages/DispatchWipPage'

// 페이지별 메타 정보 (PageFactory.java 대체)
const PAGE_META = {
  '/':                 { title: '[ 용접 로봇 AI운영 및 생산 관리 시스템 ]', tab: null },
  '/CommonCode':       { title: '기준정보관리', tab: '1-1 공통코드관리' },
  '/RobotResource':    { title: '기준정보관리', tab: '1-2 사용자 관리' },
  '/AutoAsset':        { title: '자동화 장비 자산 관리', tab: '2-1 자동화 장비 자산 관리' },
  '/Maintenance':      { title: '자동화 장비 자산 관리', tab: '2-2 유지 보수 이력 관리' },
  '/DesignInfo':       { title: '인공지능 데이터 관리', tab: '3-1 설계정보 관리' },
  '/IOTData':          { title: '인공지능 데이터 관리', tab: '3-2 Row Data 관리' },
  '/QualityModel':     { title: '인공지능 데이터 관리', tab: '3-3 용접 품질진단 모델' },
  '/SituationDataModel':{ title: '인공지능 데이터 관리', tab: '3-4 상황인지 모델 데이터' },
  '/IrRegularData':    { title: '인공지능 데이터 관리', tab: '3-5 비정형 데이터 관리' },
  '/WeldDataset':      { title: '인공지능 데이터 관리', tab: '3-6 용접 제조 데이터셋 관리' },
  '/AutoSitutation':   { title: '생산 상세 모니터링', tab: '4-1 용접 로봇 실시간 모니터링' },
  '/ProductSituation': { title: '생산 상세 모니터링', tab: '4-2 용접 로봇 공정 모니터링' },
  '/RobotLine':        { title: '생산 상세 모니터링', tab: '4-3 용접 공정 전체 모니터링' },
  '/BlockMonitering':  { title: '생산 상세 모니터링', tab: '4-4 블록별 상세공정 모니터링' },
  '/WorkOrder':        { title: '통합 생산 관리', tab: '5-1 용접 공정 생산 실행 계획 관리' },
  '/RobotOrder':       { title: '통합 생산 관리', tab: '5-2 용접 로봇 휴먼/배원 관리' },
  '/DispatchWip':      { title: '통합 생산 관리', tab: '5-3 Bay 별 배치 및 생산 관리' },
}

// 탭 히스토리 훅 (tabs.js 대체)
function useTabHistory() {
  const [tabs, setTabs] = useState([])
  const location = useLocation()

  useEffect(() => {
    const meta = PAGE_META[location.pathname]
    if (!meta?.tab) return
    setTabs(prev => {
      if (prev.find(t => t.path === location.pathname)) return prev
      return [...prev.slice(-7), { path: location.pathname, label: meta.tab }]
    })
  }, [location.pathname])

  const removeTab = (path) => setTabs(prev => prev.filter(t => t.path !== path))
  return { tabs, removeTab }
}

export default function App() {
  const location = useLocation()
  const meta = PAGE_META[location.pathname] || {}
  const { tabs, removeTab } = useTabHistory()
  const [nowTime, setNowTime] = useState('')
  const isIndex = location.pathname === '/'

  // 실시간 시계
  useEffect(() => {
    const tick = () => {
      const now = new Date()
      const pad = n => String(n).padStart(2, '0')
      const days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']
      setNowTime(
        `${now.getFullYear()}.${pad(now.getMonth()+1)}.${pad(now.getDate())} ` +
        `${days[now.getDay()]} ${pad(now.getHours())}:${pad(now.getMinutes())}`
      )
    }
    tick()
    const id = setInterval(tick, 1000)
    return () => clearInterval(id)
  }, [])

  return (
    <div style={{ display: 'flex', height: '100vh'}}>
      <Sidebar />
      {isIndex && <SideModal />}

      <div style={{ flex: 1, display: 'flex', flexDirection: 'column', overflow: 'hidden',  }}>
        {/* 메인 페이지 헤더 (index 전용) */}
        {isIndex && (
          <div className="header1" style={{marginLeft:'260px'}}>
            <span>[ 용접 로봇 AI운영 및 생산 관리 시스템 ]</span>
          </div>
        )}

        {/* 공통 상단바 (index 전용) */}
        {isIndex && (
          <div className="header2button flex justifybetween" style={{marginLeft:'260px'}}>
            <span className="nowtime">{nowTime}</span>
            <div>
              <button>로그인</button>
              <button>회원가입</button>
              <select className="ablebutton enabled">
                <option>용연공장</option>
                <option>본사</option>
                <option>해양공장</option>
                <option>온산공장</option>
              </select>
            </div>
          </div>
        )}

        {/* 탭바 (page.js + tabs.js 대체) */}
        {tabs.length > 0 && (
          <div id="tabs" className="tabs" style={{ display: 'flex', flexWrap: 'wrap' }}>
            {tabs.map(tab => (
              <span
                key={tab.path}
                className={`tab-item ${location.pathname === tab.path ? 'active-tab' : ''}`}
              >
                <Link to={tab.path}>{tab.label}</Link>
                <button
                  className="tab-close"
                  onClick={() => removeTab(tab.path)}
                  aria-label="탭 닫기"
                >×</button>
              </span>
            ))}
          </div>
        )}

        {/* 페이지 제목 (index 제외) */}
        {!isIndex && meta.title && (
          <div className="titlemenu">
            {meta.title} {meta.tab ? `[${meta.tab}]` : ''}
          </div>
        )}

        {/* 페이지 콘텐츠 영역, Routes(라우팅) - 다른 페이지로 이동 */}
        <div className={isIndex ? 'mainpage' : 'showmain'} style={{ flex: 1, overflowY: 'auto' }}>
          <Routes>
            <Route path="/"                  element={<IndexPage />} />
            <Route path="/CommonCode"        element={<CommonCodePage />} />
            <Route path="/RobotResource"     element={<RobotResourcePage />} />
            <Route path="/AutoAsset"         element={<AutoAssetPage />} />
            <Route path="/Maintenance"       element={<MaintenancePage />} />
            <Route path="/DesignInfo"        element={<DesignInfoPage />} />
            <Route path="/IOTData"           element={<IOTDataPage />} />
            <Route path="/QualityModel"      element={<QualityModelPage />} />
            <Route path="/SituationDataModel" element={<SituationDataModelPage />} />
            <Route path="/IrRegularData"     element={<IrRegularDataPage />} />
            <Route path="/WeldDataset"       element={<WeldDatasetPage />} />
            <Route path="/AutoSitutation"    element={<AutoSitutationPage />} />
            <Route path="/ProductSituation"  element={<ProductSituationPage />} />
            <Route path="/RobotLine"         element={<RobotLinePage />} />
            <Route path="/BlockMonitering"   element={<BlockMoniteringPage />} />
            <Route path="/WorkOrder"         element={<WorkOrderPage />} />
            <Route path="/RobotOrder"        element={<RobotOrderPage />} />
            <Route path="/DispatchWip"       element={<DispatchWipPage />} />
          </Routes>
        </div>

        {isIndex && (
          <footer className="text-white textcenter">
            Copyright ⓒ 2025 ACE E&T All rights reserved.
          </footer>
        )}
      </div>
    </div>
  )
}
