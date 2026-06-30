/**
 * AutoSitutationPage.jsx
 * AutoSitutation.jsp + AutoSitutation.js 통합
 * 실시간 Chart.js (3개) + 주기적 폴링
 */
import { useEffect, useRef, useState } from 'react'
import PageHeader from '../components/PageHeader'
import { fetchAutoSituation } from '../api'

const ROBOTS = [
  { no: '평균', rate: 100, arc: 20, weld: 27.4, admin: '-', status: '-' },
  { no: 'UR1',  rate: 100, arc: 41, weld: 38,   admin: 'DMIC', status: 'ON' },
  { no: 'UR3',  rate: 100, arc: 0,  weld: 0,    admin: 'DMIC', status: 'ON' },
  { no: 'UR4',  rate: 100, arc: 44, weld: 44.3, admin: 'DMIC', status: 'ON' },
]

export default function AutoSitutationPage() {
  const canvasRefs  = [useRef(null), useRef(null), useRef(null)]
  const chartInsts  = useRef([])
  const [process, setProcess] = useState({ 소조: false, 중조: true })
  const [today, setToday] = useState({ year: '', month: '', day: '' })

  useEffect(() => {
    const d = new Date()
    setToday({ year: d.getFullYear(), month: d.getMonth()+1, day: d.getDate() })
  }, [])

  useEffect(() => {
    if (!window.Chart) return
    const Ch = window.Chart

    // 이전 차트 파괴
    chartInsts.current.forEach(c => c?.destroy())
    chartInsts.current = []

    const labels = Array.from({ length: 20 }, (_, i) => `${i+1}`)
    const makeData = () => Array.from({ length: 20 }, () => Math.random() * 100)

    const configs = [
      { label: '가동율 (%)',  color: '#4e9de0' },
      { label: '아크율 (%)',  color: '#4ee0a0' },
      { label: '용접장 (m)', color: '#e0a04e' },
    ]

    canvasRefs.forEach((ref, i) => {
      if (!ref.current) return
      const inst = new Ch(ref.current, {
        type: 'line',
        data: {
          labels,
          datasets: [{
            label: configs[i].label,
            data: makeData(),
            borderColor: configs[i].color,
            backgroundColor: configs[i].color + '33',
            tension: 0.4, fill: true, pointRadius: 2
          }]
        },
        options: {
          responsive: true,
          plugins: { legend: { position: 'top' } },
          scales: { y: { beginAtZero: true } }
        }
      })
      chartInsts.current.push(inst)
    })

    // 5초마다 데이터 갱신
    const id = setInterval(() => {
      chartInsts.current.forEach(c => {
        if (!c) return
        c.data.datasets[0].data = makeData()
        c.update()
      })
    }, 5000)

    return () => {
      clearInterval(id)
      chartInsts.current.forEach(c => c?.destroy())
    }
  }, [])

  return (
    <>
      <PageHeader title="용접 로봇 실시간 작업 실적 현황">
        <input type="checkbox" checked={process.소조} onChange={e => setProcess(p=>({...p, 소조: e.target.checked}))} />소조
        <input type="checkbox" checked={process.중조} onChange={e => setProcess(p=>({...p, 중조: e.target.checked}))} />중조
        <button>검색</button>
      </PageHeader>

      <div className="flex SituationMenu">
        <div className="flex-column bgwhite AutoDiv">
          <header className="AutoDivHeader">
            <span className="EmojiSpan">📊📈</span>평균 Data{' '}
            <span style={{ color: 'yellow' }}>
              <span className="getyear">{today.year}</span>년{' '}
              <span className="getmonth">{today.month}</span>월{' '}
              <span className="getday">{today.day}</span>일
            </span> 기준
          </header>
          <div style={{ padding: 4 }}>
            <table className="width100">
              <thead>
                <tr style={{ color: 'azure' }}>
                  <th>No</th><th>협동로봇</th><th>가동율 (%)</th>
                  <th>아크율 (%)</th><th>용접장 (m)</th><th>운영자</th><th>현황</th>
                </tr>
              </thead>
              <tbody className="textcenter">
                {ROBOTS.map((r, i) => (
                  <tr key={r.no}>
                    <td>{i === 0 ? '-' : i}</td>
                    <td>{r.no}</td><td>{r.rate}</td><td>{r.arc}</td>
                    <td>{r.weld}</td><td>{r.admin}</td><td>{r.status}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
        <img className="PDF" src="/images/pdf.png" alt="PDF" />
      </div>

      <div className="flex-column canvasdiv">
        {canvasRefs.map((ref, i) => (
          <div key={i} className="SitutationChartDiv">
            <canvas ref={ref} className="SitutationChart" width="1200" height="200" />
          </div>
        ))}
      </div>
    </>
  )
}
