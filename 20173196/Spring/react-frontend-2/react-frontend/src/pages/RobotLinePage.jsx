/**
 * RobotLinePage.jsx
 * JSP 레이아웃 100% 동일 + ECharts 고퀄리티 그래프
 *
 * 레이아웃:
 *   [요약 테이블    | 가동률(%) 차트       ]  ← 상단
 *   [가동시간(시:분) | 운영시간(시:분) 차트 ]  ← 하단
 */
import { useEffect, useRef } from 'react'
import PageHeader from '../components/PageHeader'

/* ── 정적 데이터 (RobotLine.js 원본) ── */
const DAYS  = [4, 5, 6, 7, 8]
const ROBOTS = ['UR1', 'UR2', 'UR3', 'UR4']
const PALETTE = ['#1E90FF', '#DC143C', '#ADFF2F', '#8A2BE2']   // dodgerblue / crimson / greenyellow / purple

const RAW = [
  // [0] 가동률(%)
  [ [0,58.1,67.4,56.4,62.1], [71.8,0,0,92.8,78.5], [0,0,0,49.1,62.2], [0,0,64.7,0,0] ],
  // [1] 가동시간(분)
  [ [0,86,148,223,140], [0,0,0,354,212], [294,0,0,113,205], [0,0,75,0,0] ],
  // [2] 운영시간(분)
  [ [0,158,234,382,257], [0,0,0,375,285], [396,0,0,227,339], [0,0,141,0,0] ],
]

const TABLE_ROWS = [
  { name:'평균', rate:69.2, arc:56.1, weld:13.3, time:'1:34' },
  { name:'UR1',  rate:61.6, arc:55.4, weld:19.1, time:'2:03' },
  { name:'UR2',  rate:86.9, arc:53.5, weld:12.8, time:'1:52' },
  { name:'UR3',  rate:64.1, arc:66.1, weld:20.3, time:'2:01' },
  { name:'UR4',  rate:64.2, arc:49.5, weld:1.1,  time:'0:18' },
]

function toHM(v) {
  if (!v) return ''
  return `${Math.floor(v / 60)}:${String(v % 60).padStart(2,'0')}`
}

/* ── ECharts 그룹 바차트 옵션 생성 ── */
function makeOption(dataIdx, title, isPercent) {
  const series = ROBOTS.map((r, ri) => ({
    name: r,
    type: 'bar',
    barMaxWidth: 28,
    data: RAW[dataIdx][ri].map(v => ({ value: v || null })),
    itemStyle: {
      color: {
        type: 'linear', x: 0, y: 0, x2: 0, y2: 1,
        colorStops: [
          { offset: 0, color: PALETTE[ri] },
          { offset: 1, color: PALETTE[ri] + '66' },
        ],
      },
      borderRadius: [4, 4, 0, 0],
    },
    label: {
      show: true,
      position: 'top',
      color: '#e6edf3',
      fontSize: 12,
      fontWeight: 'bold',
      formatter: p => {
        if (!p.value) return ''
        return isPercent ? p.value + '%' : toHM(p.value)
      },
    },
  }))

  return {
    backgroundColor: 'transparent',
    title: {
      text: title,
      left: 'center',
      top: 6,
      textStyle: { color: '#e6edf3', fontSize: 14, fontWeight: 'bold' },
    },
    tooltip: {
      trigger: 'axis',
      axisPointer: { type: 'shadow' },
      formatter: params =>
        params[0].name + '일<br>' +
        params.map(p => {
          if (!p.value) return ''
          const val = isPercent ? p.value + '%' : toHM(p.value)
          return `${p.marker}${p.seriesName}: <b>${val}</b>`
        }).filter(Boolean).join('<br>'),
    },
    legend: {
      data: ROBOTS,
      bottom: 4,
      textStyle: { color: '#c9d1d9', fontSize: 12 },
      icon: 'roundRect',
    },
    grid: { top: 48, bottom: 42, left: 52, right: 10 },
    xAxis: {
      type: 'category',
      data: DAYS,
      axisLabel: { color: '#8b949e', fontSize: 13 },
      axisLine: { lineStyle: { color: 'rgba(255,255,255,0.15)' } },
      splitLine: { show: false },
    },
    yAxis: {
      type: 'value',
      max: isPercent ? 100 : undefined,
      splitLine: { lineStyle: { color: 'rgba(255,255,255,0.06)', type: 'dashed' } },
      axisLabel: {
        color: '#8b949e',
        fontSize: 12,
        formatter: v => isPercent ? v + '%' : toHM(v),
      },
    },
    series,
  }
}

export default function RobotLinePage() {
  const ec0 = useRef(null)   // 가동률
  const ec1 = useRef(null)   // 가동시간
  const ec2 = useRef(null)   // 운영시간
  const inst = useRef([])

  useEffect(() => {
    if (!window.echarts) return

    const targets = [
      { ref: ec0, idx: 0, title: '가동률(%)',       isPercent: true  },
      { ref: ec1, idx: 1, title: '가동시간(시:분)', isPercent: false },
      { ref: ec2, idx: 2, title: '운영시간(시:분)', isPercent: false },
    ]

    inst.current.forEach(c => c?.dispose())
    inst.current = targets.map(({ ref, idx, title, isPercent }) => {
      if (!ref.current) return null
      const chart = window.echarts.init(ref.current, 'dark')
      chart.setOption(makeOption(idx, title, isPercent))
      return chart
    })

    const onResize = () => inst.current.forEach(c => c?.resize())
    window.addEventListener('resize', onResize)
    return () => {
      window.removeEventListener('resize', onResize)
      inst.current.forEach(c => c?.dispose())
    }
  }, [])

  return (
    <>
      <PageHeader title="용접 실적 휴먼/로봇 통합 로봇 모니터링">
        <label><input type="checkbox" value="소조" /> 소조</label>
        <label><input type="checkbox" value="중조" defaultChecked /> 중조</label>
        <button>검색</button>
      </PageHeader>

      {/* 필터 */}
      <div className="flex formstyle">
        <label className="width25 flex">
          <span>작업일자 </span>
          <input type="date" className="formtext" defaultValue="2025-04-17" />
        </label>
        <label className="width25 flex">
          <span>작업호선 </span>
          <input type="text" className="formtext" defaultValue="ALL" />
        </label>
        <label className="width25 flex">
          <span>공장 </span>
          <input type="text" className="formtext" defaultValue="용연공장" />
        </label>
        <label className="width25 flex" style={{ gap: 8 }}>
          {['일별','주별','월별','년별'].map(v => (
            <label key={v}>
              <input type="radio" name="period" defaultChecked={v === '월별'} /> {v}
            </label>
          ))}
        </label>
      </div>

      {/* ── 2×2 균등 그리드: 테이블 | 가동률 / 가동시간 | 운영시간 ── */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: '1fr 1fr',
        gridTemplateRows: '1fr 1fr',
        gap: 10,
        padding: '8px',
        height: 'calc(100vh - 215px)',   /* 헤더+필터 제외한 나머지 전체 */
      }}>

        {/* [1,1] 요약 테이블 */}
        <table className="RobotLineTable" style={{ fontSize: 13, alignSelf: 'center' }}>
          <thead>
            <tr>
              <th>구분</th>
              <th>가동률(%)</th>
              <th>아크율(%)<br />가동시간 기준</th>
              <th>용접장(m)</th>
              <th>가동시간<br />(시:분)</th>
            </tr>
          </thead>
          <tbody>
            {TABLE_ROWS.map((r, i) => (
              <tr key={i}>
                <td>{r.name}</td><td>{r.rate}</td>
                <td>{r.arc}</td><td>{r.weld}</td><td>{r.time}</td>
              </tr>
            ))}
          </tbody>
        </table>

        {/* [1,2] 가동률 ECharts */}
        <div ref={ec0} style={{ width: '100%', height: '100%' }} />

        {/* [2,1] 가동시간 ECharts */}
        <div ref={ec1} style={{ width: '100%', height: '100%' }} />

        {/* [2,2] 운영시간 ECharts */}
        <div ref={ec2} style={{ width: '100%', height: '100%' }} />
      </div>
    </>
  )
}
