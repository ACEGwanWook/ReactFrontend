/**
 * SideModal.jsx
 * sidemodal.jsp 완전 재현
 * - 우측에서 슬라이드인
 * - → 버튼으로 닫기 / ← 버튼으로 열기
 * - 생산 공정 현황, 금일 용접 작업 현황, 로봇 현황, 용접 로봇 KPI
 */
import { useEffect, useState } from 'react'
import { fetchMainPage } from '../api'

export default function SideModal() {
  const [open,       setOpen]       = useState(false)
  const [process,    setProcess]    = useState([])
  const [todayWeld,  setTodayWeld]  = useState([])
  const [robotKPI,   setRobotKPI]   = useState([])

  useEffect(() => {
    fetchMainPage()
      .then(data => {
        setProcess(data.getProcess   || [])
        setTodayWeld(data.getTodayWeld || [])
        setRobotKPI(data.getRobotKPI   || [])
      })
      .catch(console.error)
  }, [])

  return (
    <>
      {/* 열기 버튼 — 모달이 닫혀 있을 때만 표시 */}
      {!open && (
        <button
          onClick={() => setOpen(true)}
          style={{
            position: 'fixed', right: 0, top: '50%',
            transform: 'translateY(-50%)',
            zIndex: 1000,
            display: 'flex', alignItems: 'center', gap: 6,
            padding: '10px 16px', cursor: 'pointer',
            background: 'linear-gradient(135deg, #1a3f7a, #1d4ed8)',
            border: '1px solid var(--c-bdr-l)',
            borderRight: 'none', borderRadius: '8px 0 0 8px',
            boxShadow: '-2px 0 10px rgba(0,0,0,0.35)',
            color: '#ffffff', fontSize: 15, fontWeight: 700,
            letterSpacing: '0.06em'
          }}
        >
          ← KPI
        </button>
      )}

      {/* 모달 패널 */}
      <div style={{
        position: 'fixed', right: open ? 0 : '-340px', top: 0,
        width: 340, height: '100vh',
        background: 'var(--c-panel)',
        borderLeft: '1px solid var(--c-bdr-l)',
        zIndex: 999, overflowY: 'auto',
        transition: 'right 0.3s ease',
        boxShadow: open ? '-4px 0 16px rgba(0,0,0,0.45)' : 'none'
      }}>
        {/* 닫기 버튼 — 패널 상단 고정 */}
        <div style={{ position: 'sticky', top: 0,
          background: 'var(--c-panel)',
          padding: '6px 8px', textAlign: 'right',
          borderBottom: '1px solid var(--c-bdr)', zIndex:1000 }}>
          <button
            onClick={() => setOpen(false)}
            style={{
              cursor: 'pointer', padding: '4px 12px', fontSize: 16, fontWeight: 700,
              background: 'var(--c-hover)',
              border: '1px solid var(--c-bdr-l)',
              borderRadius: 4, color: 'var(--c-tp)',
              display: 'inline-block', visibility: 'visible', zIndex:1000
            }}
          >
            →
          </button>
        </div>

        <div className="sidemodal" style={{ padding: '0 12px 20px' }}>

          {/* ── 생산 공정 현황 ──────────────────────── */}
          <div className="preceding">
            <h5 className="factorysituation">생산 공정 현황</h5>
            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 12 }}>
              <thead>
                <tr className="ttitle">
                  <th rowSpan={2} className="tabletopleft">구분</th>
                  <th colSpan={3}>공정률(%)</th>
                  <th colSpan={3} className="tabletopright">미처리 수량[EA]</th>
                </tr>
                <tr className="ttitle">
                  <th>실적</th><th>예상</th><th>증감</th>
                  <th>실적</th><th>예상</th><th className="topright">증감</th>
                </tr>
              </thead>
              <tbody>
                {process.map((p, i) => (
                  <tr key={i}>
                    <td className="ttitle">{p.division}</td>
                    <td>{p.performance}</td>
                    <td>{p.expectation}</td>
                    <td>
                      {p.performance > p.expectation
                        ? <span className="up">↑</span>
                        : <span className="down">↓</span>}
                      {' '}{p.diff}
                    </td>
                    <td className="tdbg">{p.unproperfom > 0 ? p.unproperfom : ''}</td>
                    <td className="tdbg">{p.unproexpect > 0 ? p.unproexpect : ''}</td>
                    <td className="tdbg topright">{p.unprodiff > 0 ? p.unprodiff + '%' : ''}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* ── 금일 용접 작업 현황 ─────────────────── */}
          <div className="population" style={{ marginTop: 16 }}>
            <h5>금일 용접 작업 현황</h5>
            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 12 }}>
              <thead>
                <tr className="ttitle">
                  <th className="tabletopleft">공정</th>
                  <th>계획</th><th>실적</th><th>진척률</th>
                  <th>불량</th><th className="tabletopright">불량률</th>
                </tr>
              </thead>
              <tbody>
                {todayWeld.map((w, i) => (
                  <tr key={i} className="trstyle">
                    <td className="ttitle">{w.process}</td>
                    <td>{w.expectation}</td>
                    <td>{w.performance}</td>
                    <td>{w.progress}%</td>
                    <td>{w.error}</td>
                    <td>{w.errorrate}%</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* ── 로봇 현황 ───────────────────────────── */}
          <div className="robot" style={{ marginTop: 16 }}>
            <h5>로봇 현황</h5>
            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 12 }}>
              <thead>
                <tr className="ttitle">
                  <th className="tabletopleft">구분</th>
                  <th>수량</th><th>가동</th><th>대기</th>
                  <th>불가</th><th className="tabletopright">가동률</th>
                </tr>
              </thead>
              <tbody>
                {robotKPI.map((r, i) => (
                  <tr key={i} className="trstyle">
                    <td className="ttitle">{r.robot}</td>
                    <td>{r.robotcount}</td>
                    <td>{r.operate}</td>
                    <td>{r.wait}</td>
                    <td>{r.error}</td>
                    <td>{r.operationrate}%</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* ── 용접 로봇 KPI ───────────────────────── */}
          <div className="kpidiv" style={{ marginTop: 16 }}>
            <h5>용접 로봇 KPI</h5>
            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: 12 }}>
              <thead>
                <tr className="ttitle">
                  <th className="tabletopleft">구분</th>
                  {robotKPI.map((r, i) => <th key={i}>{r.robot}</th>)}
                  <th>기타</th>
                  <th className="tabletopright">평균</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <th className="ttitle localname">제어율</th>
                  {robotKPI.map((r, i) => <th key={i}>{r.controlrate}%</th>)}
                  <th>-</th><th>85%</th>
                </tr>
                <tr>
                  <th className="ttitle localname">생산성</th>
                  {robotKPI.map((r, i) => <th key={i}>{r.productivity}%</th>)}
                  <th>-</th><th>20%</th>
                </tr>
                <tr>
                  <th className="ttitle localname">정확도</th>
                  {robotKPI.map((r, i) => <th key={i}>{r.accuracy}%</th>)}
                  <th>-</th><th>95%</th>
                </tr>
              </tbody>
            </table>
          </div>

        </div>
      </div>
    </>
  )
}
