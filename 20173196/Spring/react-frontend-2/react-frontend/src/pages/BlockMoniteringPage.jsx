/**
 * BlockMoniteringPage.jsx
 * BlockMonitering.jsp 완전 재현
 *
 * 레이아웃:
 *   - 좌: 블록 상세 정보 패널 (블록 클릭 시 표시)
 *   - 우: 4×4 블록 이미지 버튼 그리드
 */
import { useState } from 'react'
import PageHeader from '../components/PageHeader'

/* ── 블록 데이터 ────────────────────────────────────────── */
const BLOCKS = [
  // row 1
  { id: 'B12PTT', label: 'B12P', type: 'TT', img: '/images/B12PTT.png' },
  { id: 'B13PTT', label: 'B13P', type: 'TT', img: '/images/B13PTT.png' },
  { id: 'B14PTT', label: 'B14P', type: 'TT', img: '/images/B14PTT.png' },
  { id: 'B15PTT', label: 'B15P', type: 'TT', img: '/images/B15PTT.png' },
  // row 2
  { id: 'B12STT', label: 'B12S', type: 'TT', img: '/images/B12STT.png' },
  { id: 'B13STT', label: 'B13S', type: 'TT', img: '/images/B13STT.png' },
  { id: 'B14STT', label: 'B14S', type: 'TT', img: '/images/B14STT.png' },
  { id: 'B15STT', label: 'B15S', type: 'TT', img: '/images/B15STT.png' },
  // row 3
  { id: 'B16PTT', label: 'B16P', type: 'TT', img: '/images/B16PTT.png' },
  { id: 'B17PTT', label: 'B17P', type: 'TT', img: '/images/B17PTT.png' },
  { id: 'B18PTT', label: 'B18P', type: 'TT', img: '/images/B18PTT.png' },
  { id: 'S14PLB', label: 'S14P', type: 'LB', img: '/images/S14PLB.png' },
  // row 4
  { id: 'B16STT', label: 'B16S', type: 'TT', img: '/images/B16STT.png' },
  { id: 'B17STT', label: 'B17S', type: 'TT', img: '/images/B17STT.png' },
  { id: 'B18STT', label: 'B18S', type: 'TT', img: '/images/B18STT.png' },
  { id: 'S14SLB', label: 'S14S', type: 'LB', img: '/images/S14SLB.png' },
]

/* 블록별 상세 정보 (mock) */
const BLOCK_DETAIL = {
  default: {
    p1block: '1B16', weight: '125', lot: 'Y03B',
    schedule: [
      '조립반출 실행(중일정) : [용연]02/07 (02/10)',
      '선의착수 실행(중일정) : [용연]02/25 (02/25)',
      '선의완료 실행(중일정) : [용연]03/10 (03/10)',
      '1PE착수 실행(중일정) : [용연]02/26 (02/26)',
      '1PE완료 실행(중일정) : [용연]03/10 (03/10)',
      '1PE의장 실행(중일정) : [용연]02/26 (02/26)',
      '1PE의장 실행(중일정) : [용연]03/10 (03/10)',
      '도장착수 실행(중일정) : [용연] (03/20)',
      '도장완료 실행(중일정) : [용연] (04/03)',
      '2PE착수 실행(중일정) : [해양]04/14 (04/14)',
      '2PE완료 실행(중일정) : [해양]04/25 (04/25)',
      '탑재 실행(중일정) : [본사] 05/07',
    ],
  },
}

const STAGES = [
  '-', '조립반출 실행', '선의착수 실행', '선의완료 실행',
  '1PE착수 실행', '1PE완료 실행', '1PE의장 실행',
  '도장착수 실행', '도장완료 실행', '2PE착수 실행',
  '2PE완료 실행', '탑재 실행',
]

export default function BlockMoniteringPage() {
  const [selected,   setSelected]   = useState(null)   // 선택된 블록
  const [panelOpen,  setPanelOpen]  = useState(false)  // 좌측 패널 표시
  const [filter, setFilter] = useState({ stage:'', startDate:'', endDate:'', line:'289906', block:'B16S' })

  function handleBlockClick(block) {
    setSelected(block)
    setPanelOpen(true)
  }

  function handleSearch() {
    setPanelOpen(!!selected)
  }

  const detail = BLOCK_DETAIL.default

  return (
    <>
      <PageHeader title="블록별 생산 계획 정보 현황">
        <button onClick={handleSearch}>검색</button>
      </PageHeader>

      {/* ── 필터 ── */}
      <div className="flex formstyle">
        <label className="width20 flex">
          <span>블록 스테이지</span>
          <select className="formtext"
            value={filter.stage} onChange={e => setFilter(p=>({...p, stage:e.target.value}))}>
            {STAGES.map(s => <option key={s} value={s === '-' ? '' : s}>{s}</option>)}
          </select>
        </label>
        <label className="width20 flex">
          <span>시작 날짜</span>
          <input type="date" className="formtext"
            value={filter.startDate} onChange={e => setFilter(p=>({...p, startDate:e.target.value}))} />
        </label>
        <label className="width20 flex">
          <span>종료 날짜</span>
          <input type="date" className="formtext"
            value={filter.endDate} onChange={e => setFilter(p=>({...p, endDate:e.target.value}))} />
        </label>
        <label className="width20 flex">
          <span>호선</span>
          <input type="text" className="formtext"
            value={filter.line} onChange={e => setFilter(p=>({...p, line:e.target.value}))} />
        </label>
        <label className="width20 flex">
          <span>블록</span>
          <input type="text" className="formtext"
            value={filter.block} onChange={e => setFilter(p=>({...p, block:e.target.value}))} />
        </label>
      </div>

      {/* ── 메인 영역 ── */}
      <div className="width100 flex Monitering" style={{ gap: 0, overflow: 'hidden', height: 'calc(100vh - 165px)' }}>

        {/* 좌측 상세 패널 */}
        {panelOpen && selected && (
          <div className="flexcolumn" style={{
            width: 220, flexShrink: 0,
            background: 'var(--color-background-secondary)',
            border: '1px solid var(--color-border-secondary)',
            display: 'flex', flexDirection: 'column', overflow: 'hidden',
          }}>
            {/* 패널 헤더 */}
            <div className="BlockHeader flex justifybetween" style={{
              padding: '8px 12px',
              background: '#1E90FF',
              color: 'white',
              display: 'flex', alignItems: 'center', justifyContent: 'space-between',
            }}>
              <span style={{ fontWeight: 'bold', fontSize: 14 }}>
                {filter.line}-{selected.label}{selected.type}
              </span>
              <button
                className="BlockClose"
                onClick={() => setPanelOpen(false)}
                style={{ background: 'transparent', border: 'none', color: 'white',
                  fontSize: 16, cursor: 'pointer', fontWeight: 'bold' }}>
                X
              </button>
            </div>

            {/* 패널 본문 */}
            <div style={{ padding: 10, flex: 1, overflowY: 'auto' }}>
              <div className="flex justifybetween" style={{ fontSize: 12, marginBottom: 8, gap: 6 }}>
                <span>P1블록 : {detail.p1block}</span>
                <span>중량 : {detail.weight}</span>
                <span>지번 : {detail.lot}</span>
              </div>
              <div className="blockinfo flexcolumn" style={{ display: 'flex', flexDirection: 'column', gap: 4 }}>
                {detail.schedule.map((s, i) => (
                  <span key={i} style={{ fontSize: 11, color: 'var(--color-text-secondary)' }}>{s}</span>
                ))}
              </div>
            </div>
          </div>
        )}

        {/* 우측 블록 이미지 그리드 */}
        <div style={{
          flex: 1,
          display: 'grid',
          gridTemplateColumns: 'repeat(4, 1fr)',
          gridTemplateRows: 'repeat(4, 1fr)',
          gap: 2,
          padding: 8,
          overflow: 'hidden',
          background: 'var(--color-background)',
        }}>
          {BLOCKS.map(block => (
            <button
              key={block.id}
              onClick={() => handleBlockClick(block)}
              style={{
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
                background: selected?.id === block.id
                  ? 'rgba(30, 144, 255, 0.15)'
                  : 'var(--color-background-secondary)',
                border: selected?.id === block.id
                  ? '2px solid #1E90FF'
                  : '1px solid var(--color-border-secondary)',
                borderRadius: 4,
                cursor: 'pointer',
                padding: 4,
                overflow: 'hidden',
                transition: 'border-color 0.15s, background 0.15s',
              }}
            >
              <img
                src={block.img}
                alt={block.label}
                style={{ width: '100%', height: 'calc(100% - 28px)', objectFit: 'contain' }}
              />
              <span style={{
                fontSize: 13, fontWeight: 'bold', marginTop: 2,
                color: selected?.id === block.id ? '#1E90FF' : 'var(--color-text-primary)',
              }}>
                {block.label}<br />
                <span style={{ fontSize: 11, fontWeight: 'normal',
                  color: 'var(--color-text-secondary)' }}>({block.type})</span>
              </span>
            </button>
          ))}
        </div>
      </div>
    </>
  )
}
