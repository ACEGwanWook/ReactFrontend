/**
 * WeldDatasetPage.jsx
 * WeldDataset.jsp + WeldDataset.js 완전 재현
 * - 정적 데이터 (DB 미사용)
 * - 좌: ECharts 시간비교 그룹바 / 우: Chart.js 2×2 그리드
 * - 행 클릭 → 해당 행 데이터로 차트 업데이트
 */
import { useEffect, useRef, useState } from 'react'
import PageHeader from '../components/PageHeader'

// ── 전체 데이터 (WeldDataset.js allRows 동일) ──────────────
const ALL_ROWS = [
  { label: 'A-A', 가동시간: 107.2, 용접시간: 96.3, 터치시간: 4.6, 교차시간: 6.3,  용접장: 1400, 용접봉: 292.41, 품질: 98,   누적수량: 25400 },
  { label: 'A-B', 가동시간: 98.6,  용접시간: 86.7, 터치시간: 6.7, 교차시간: 5.2,  용접장: 1357, 용접봉: 255.83, 품질: 99.4, 누적수량: 30000 },
  { label: 'C-D', 가동시간: 96.7,  용접시간: 85.1, 터치시간: 3.8, 교차시간: 7.8,  용접장: 1440, 용접봉: 234.19, 품질: 97,   누적수량: 24500 },
]

function avg(key) { return ALL_ROWS.reduce((s, r) => s + r[key], 0) / ALL_ROWS.length }
const AVG_ROW = {
  label: '평균',
  가동시간: avg('가동시간'), 용접시간: avg('용접시간'),
  터치시간: avg('터치시간'), 교차시간: avg('교차시간'),
  용접장:   avg('용접장'),  용접봉:   avg('용접봉'),
  품질:     avg('품질'),    누적수량:  avg('누적수량'),
}

const PAL = {
  blue: '#4a90d9', gray: '#6b7280', green: '#3fb950',
  orange: '#d29922', purple: '#a78bfa',
  grid: 'rgba(255,255,255,0.06)', text: '#8b949e',
}

export default function WeldDatasetPage() {
  const [selIdx, setSelIdx] = useState(0)

  // ECharts ref
  const ecRef    = useRef(null)
  const ecInst   = useRef(null)
  // Chart.js refs
  const cWeldLen = useRef(null)
  const cWeldRod = useRef(null)
  const cQuality = useRef(null)
  const cQty     = useRef(null)
  const cjsInst  = useRef({})

  const sel = ALL_ROWS[selIdx]

  // ECharts 시간비교 차트
  function makeTimeChart(row) {
    if (!ecRef.current || !window.echarts) return
    if (!ecInst.current) ecInst.current = window.echarts.init(ecRef.current, 'dark')
    const keys   = ['가동시간', '용접시간', '터치시간', '교차시간']
    const colors = [PAL.blue, PAL.green, PAL.orange, PAL.purple]
    ecInst.current.setOption({
      backgroundColor: 'transparent',
      tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' } },
      legend: { data: keys, top: 8, textStyle: { color: '#e6edf3', fontSize: 11 } },
      grid: { top: 48, bottom: 28, left: 40, right: 16 },
      xAxis: { type: 'category', data: [row.label, '평균'],
        axisLabel: { color: PAL.text }, axisLine: { lineStyle: { color: PAL.grid } } },
      yAxis: { type: 'value', max: 130, splitLine: { lineStyle: { color: PAL.grid } },
        axisLabel: { color: PAL.text, formatter: '{value}분' } },
      series: keys.map((key, i) => ({
        name: key, type: 'bar', barMaxWidth: 28,
        data: [
          { value: row[key],     itemStyle: { color: colors[i], opacity: 0.95 } },
          { value: AVG_ROW[key], itemStyle: { color: colors[i], opacity: 0.45 } },
        ],
        label: { show: true, position: 'top', color: '#c9d1d9', fontSize: 10,
          formatter: p => p.value.toFixed(1) },
      })),
    })
  }

  // Chart.js 기본 옵션
  function baseCjsOpts(yMax, unit) {
    return {
      responsive: true, maintainAspectRatio: false,
      plugins: {
        legend: { display: false },
        datalabels: {
          color: '#c9d1d9', anchor: 'end', align: 'end', font: { size: 10 },
          formatter: v => v.toFixed(unit === '%' ? 1 : 0) + unit,
        },
      },
      scales: {
        x: { grid: { color: PAL.grid }, ticks: { color: PAL.text } },
        y: { max: yMax, grid: { color: PAL.grid }, ticks: { color: PAL.text } },
      },
    }
  }

  // Chart.js 단순 2-bar
  function makeCjsChart(ref, key, instKey, yMax, unit, label, annotLine) {
    if (!ref.current || !window.Chart) return
    if (cjsInst.current[instKey]) { cjsInst.current[instKey].destroy() }
    const ctx = ref.current.getContext('2d')
    const gSel = ctx.createLinearGradient(0, 0, 0, 200)
    gSel.addColorStop(0, 'rgba(74,144,217,0.95)')
    gSel.addColorStop(1, 'rgba(74,144,217,0.5)')
    const gAvg = ctx.createLinearGradient(0, 0, 0, 200)
    gAvg.addColorStop(0, 'rgba(107,114,128,0.7)')
    gAvg.addColorStop(1, 'rgba(107,114,128,0.3)')
    const opts = baseCjsOpts(yMax, unit)
    if (annotLine != null && window.Chart.registry?.plugins?.get?.('annotation')) {
      opts.plugins.annotation = {
        annotations: { line1: {
          type: 'line', yMin: annotLine, yMax: annotLine,
          borderColor: 'rgba(248,81,73,0.8)', borderWidth: 1.5, borderDash: [6, 4],
          label: { display: true, content: label + ' ' + annotLine + unit,
            position: 'end', color: 'rgba(248,81,73,0.9)', font: { size: 10 } },
        }},
      }
    }
    cjsInst.current[instKey] = new window.Chart(ctx, {
      type: 'bar',
      data: {
        labels: [sel.label, '평균'],
        datasets: [{
          label, data: [sel[key], AVG_ROW[key]],
          backgroundColor: [gSel, gAvg],
          borderColor: ['rgba(74,144,217,1)', 'rgba(107,114,128,0.8)'],
          borderWidth: 1, borderRadius: 4, borderSkipped: false,
        }],
      },
      options: opts,
    })
  }

  // 품질 차트 (초록색)
  function makeQualityChart(row) {
    if (!cQuality.current || !window.Chart) return
    if (cjsInst.current.quality) cjsInst.current.quality.destroy()
    const ctx = cQuality.current.getContext('2d')
    const gSel = ctx.createLinearGradient(0, 0, 0, 200)
    gSel.addColorStop(0, 'rgba(63,185,80,0.9)')
    gSel.addColorStop(1, 'rgba(63,185,80,0.4)')
    const gAvg = ctx.createLinearGradient(0, 0, 0, 200)
    gAvg.addColorStop(0, 'rgba(107,114,128,0.7)')
    gAvg.addColorStop(1, 'rgba(107,114,128,0.3)')
    const opts = baseCjsOpts(100, '%')
    opts.scales.y.ticks = { color: PAL.text, callback: v => v + '%' }
    cjsInst.current.quality = new window.Chart(ctx, {
      type: 'bar',
      data: {
        labels: [row.label, '평균'],
        datasets: [{
          label: '품질 (%)', data: [row.품질, AVG_ROW.품질],
          backgroundColor: [gSel, gAvg],
          borderColor: ['rgba(63,185,80,1)', 'rgba(107,114,128,0.8)'],
          borderWidth: 1, borderRadius: 4, borderSkipped: false,
        }],
      },
      options: opts,
    })
  }

  // 선택 행 바뀔 때 전체 차트 재렌더
  useEffect(() => {
    const row = ALL_ROWS[selIdx]
    setTimeout(() => {
      makeTimeChart(row)
      makeCjsChart(cWeldLen, '용접장',  'weldLen', 1500,  'mm',  '용접장 (mm)')
      makeCjsChart(cWeldRod, '용접봉',  'weldRod', 300,   'mm',  '용접봉 (mm)', 270)
      makeQualityChart(row)
      makeCjsChart(cQty,     '누적수량', 'qty',    30000,  '개',  '누적수량 (개)')
    }, 50)
  }, [selIdx])

  // resize
  useEffect(() => {
    const fn = () => ecInst.current?.resize()
    window.addEventListener('resize', fn)
    return () => {
      window.removeEventListener('resize', fn)
      ecInst.current?.dispose()
      Object.values(cjsInst.current).forEach(c => c?.destroy())
    }
  }, [])

  const qualityColor = q => q >= 98 ? 'var(--c-ok, #3fb950)' : 'var(--c-warn, #d29922)'

  return (
    <>
      <PageHeader title="CELL 별 용접 공정 데이터">
        <label><input type="checkbox" value="소조" style={{ accentColor: 'var(--c-acc)' }} /> 소조</label>
        <label><input type="checkbox" value="중조" defaultChecked style={{ accentColor: 'var(--c-acc)' }} /> 중조</label>
      </PageHeader>

      {/* ── 데이터 테이블 ── */}
      <table className="DataSet wds-table">
        <thead>
          <tr>
            <th>No</th><th>표준타입</th>
            <th>가동시간</th><th>용접시간</th><th>터치시간</th><th>교차시간</th>
            <th>용접장</th><th>용접봉</th><th>전압</th><th>전류</th>
            <th>품질</th><th>누적수량</th>
          </tr>
        </thead>
        <tbody>
          {ALL_ROWS.map((r, i) => (
            <tr key={i}
              onClick={() => setSelIdx(i)}
              style={{
                cursor: 'pointer',
                background:  i === selIdx ? 'var(--c-active, #1f2d3d)' : '',
                color:       i === selIdx ? 'var(--c-info, #4a90d9)'   : '',
                fontWeight:  i === selIdx ? 700 : 400,
              }}>
              <td>{i+1}</td><td>{r.label}</td>
              <td>{r.가동시간}</td><td>{r.용접시간}</td>
              <td>{r.터치시간}</td><td>{r.교차시간}</td>
              <td>{r.용접장}mm</td><td>{r.용접봉}mm</td>
              <td>{i === 0 ? '34.3V' : i === 1 ? '33.6V' : '26.7V'}</td>
              <td>{i < 2 ? '310A' : '185A'}</td>
              <td style={{ color: qualityColor(r.품질), fontWeight: 700 }}>{r.품질}%</td>
              <td>{r.누적수량.toLocaleString()}</td>
            </tr>
          ))}
        </tbody>
      </table>

      {/* ── 차트 레이아웃 ── */}
      <div className="wds-layout">

        {/* 좌: ECharts 시간비교 */}
        <div className="wds-card">
          <div className="wds-card-title">시간 비교 (분)</div>
          <div className="wds-canvas-wrap" ref={ecRef} style={{ height: 280 }} />
        </div>

        {/* 우: Chart.js 2×2 */}
        <div className="wds-right">
          <div className="wds-card">
            <div className="wds-card-title">용접장 (mm)</div>
            <div className="wds-canvas-wrap">
              <canvas ref={cWeldLen} />
            </div>
          </div>
          <div className="wds-card">
            <div className="wds-card-title">용접봉 (mm)</div>
            <div className="wds-canvas-wrap">
              <canvas ref={cWeldRod} />
            </div>
          </div>
          <div className="wds-card">
            <div className="wds-card-title">품질 (%)</div>
            <div className="wds-canvas-wrap">
              <canvas ref={cQuality} />
            </div>
          </div>
          <div className="wds-card">
            <div className="wds-card-title">누적수량 (개)</div>
            <div className="wds-canvas-wrap">
              <canvas ref={cQty} />
            </div>
          </div>
        </div>
      </div>
    </>
  )
}
