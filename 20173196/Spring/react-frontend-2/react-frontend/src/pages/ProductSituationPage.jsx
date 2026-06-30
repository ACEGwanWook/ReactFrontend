/**
 * ProductSituationPage.jsx
 * ProductSituation.jsp + ProductSituation.js 완전 재현
 *
 * 차트: Line (1~12월 X축)
 *   - dataset 1: "2025년"  → workTimes
 *   - dataset 2: "3년 평균" → cuttingAmount
 *
 * 필터: 작업일자 / 로봇번호 / 지표(용접장·아크율·가동시간) / 기간(일·주·월·년)
 */
import { useEffect, useRef, useState } from 'react'
import PageHeader from '../components/PageHeader'

export default function ProductSituationPage() {
  const chartRef  = useRef(null)
  const chartInst = useRef(null)

  const [chartData, setChartData] = useState([])
  const [filter, setFilter] = useState({
    date: '', robotNo: '', metric: '용접장', period: '년별'
  })

  // DB에서 ps_chart 데이터 로드
  useEffect(() => {
    fetch('/api/monitoring/product-situation')
      .then(r => r.json())
      .then(setChartData)
      .catch(console.error)
  }, [])

  // 차트 렌더
  useEffect(() => {
    if (!chartRef.current || !window.Chart || chartData.length === 0) return
    if (chartInst.current) chartInst.current.destroy()

    const labels       = chartData.map(d => d.month + '월')
    const workTimes    = chartData.map(d => d.workTimes)
    const cuttingAmt   = chartData.map(d => d.cuttingAmount)

    chartInst.current = new window.Chart(chartRef.current, {
      type: 'line',
      data: {
        labels,
        datasets: [
          {
            label: '2025년',
            data: workTimes,
            borderWidth: 1,
            fill: false,
            backgroundColor: 'deepskyblue',
            borderColor: 'deepskyblue',
            pointBackgroundColor: 'deepskyblue',
            tension: 0.3,
          },
          {
            label: '3년 평균',
            data: cuttingAmt,
            borderWidth: 1,
            fill: false,
            backgroundColor: 'lightseagreen',
            borderColor: 'lightseagreen',
            pointBackgroundColor: 'lightseagreen',
            tension: 0.3,
          },
        ],
      },
      options: {
        responsive: true,
        plugins: {
          legend: {
            display: true,
            position: 'bottom',
            labels: { color: 'white' },
          },
          datalabels: { display: true, color: 'white' },
        },
        scales: {
          x: { ticks: { color: 'white' } },
          y: { beginAtZero: true, ticks: { color: 'white' } },
        },
      },
    })
    return () => chartInst.current?.destroy()
  }, [chartData])

  function sf(field) {
    return e => setFilter(p => ({ ...p, [field]: e.target.value }))
  }

  return (
    <>
      <PageHeader title="용접 로봇 통합 모니터링">
        <label><input type="checkbox" value="소조" /> 소조</label>
        <label><input type="checkbox" value="중조" defaultChecked /> 중조</label>
        <button>검색</button>
      </PageHeader>

      {/* 검색 필터 */}
      <div className="flex formstyle">
        <label className="width25 flex">
          <span>작업일자 </span>
          <input type="date" className="formtext"
            value={filter.date} onChange={sf('date')} />
        </label>
        <label className="width25 flex">
          <span>로봇번호 </span>
          <input type="text" className="formtext"
            value={filter.robotNo} onChange={sf('robotNo')} />
        </label>
        <label className="width25 flex" style={{ gap: 8 }}>
          {['용접장', '아크율', '가동시간'].map(v => (
            <label key={v}>
              <input type="radio" name="option"
                checked={filter.metric === v}
                onChange={() => setFilter(p => ({ ...p, metric: v }))} />
              {v}
            </label>
          ))}
        </label>
        <label className="width25 flex" style={{ gap: 8 }}>
          {['일별', '주별', '월별', '년별'].map(v => (
            <label key={v}>
              <input type="radio" name="radio"
                checked={filter.period === v}
                onChange={() => setFilter(p => ({ ...p, period: v }))} />
              {v}
            </label>
          ))}
        </label>
      </div>

      {/* 라인 차트 */}
      <canvas ref={chartRef} style={{ maxHeight: 650 }} />
    </>
  )
}
