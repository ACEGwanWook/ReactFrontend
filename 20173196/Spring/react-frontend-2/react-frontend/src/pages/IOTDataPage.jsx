import { useEffect, useRef, useState } from 'react'
import PageHeader from '../components/PageHeader'
import DataTable from '../components/DataTable'
import { fetchIotJoinAll, fetchIotSummary, fetchIotRecords } from '../api'

const FILE_COLS = [
  { headerName:'No',     valueGetter:'node.rowIndex+1', width:60 },
  { headerName:'공정',   valueGetter:()=>'종조 Cell',   flex:1 },
  { headerName:'로봇No', valueGetter:()=>'UR08',        flex:1 },
  { headerName:'일자',   field:'work_date',   flex:1 },
  { headerName:'호선',   field:'vessel_no',  flex:1 },
  { headerName:'블록',   field:'block',      flex:1 },
  { headerName:'Assy',  field:'assy',       flex:1 },
]
const REC_COLS = [
  { headerName:'No',        valueGetter:'node.rowIndex+1', width:55 },
  { headerName:'시작',      field:'time_start',      flex:1 },
  { headerName:'종료',      field:'time_end',        flex:1 },
  { headerName:'아크시간',  field:'arc_time_rec',    flex:1 },
  { headerName:'용접장(mm)',field:'weld_length_rec', flex:1 },
  { headerName:'설정전류',  field:'set_current',     flex:1 },
  { headerName:'출력전류',  field:'out_current',     flex:1 },
  { headerName:'설정전압',  field:'set_voltage',     flex:1 },
  { headerName:'출력전압',  field:'out_voltage',     flex:1 },
  { headerName:'셀형상',    field:'cell_shape',      flex:1 },
  { headerName:'구간',      field:'section',         flex:1 },
  { headerName:'각장',      field:'leg_length',      flex:1 },
  { headerName:'전체패스',  field:'total_pass',      flex:1 },
  { headerName:'현재패스',  field:'current_pass',    flex:1 },
]

const chartRefs = { current:null, voltage:null, cellShape:null, section:null }

export default function IOTDataPage() {
  const [activeTab,setActiveTab]=useState('profile')
  const [files,setFiles]=useState([])
  const [summary,setSummary]=useState(null)
  const [records,setRecords]=useState([])
  const cRefs={ cur:useRef(null), vol:useRef(null), cel:useRef(null), sec:useRef(null) }
  const cInst=useRef({})

  useEffect(()=>{
    fetchIotJoinAll().then(setFiles).catch(console.error)
    fetchIotSummary().then(d=>setSummary(d[0]||null)).catch(console.error)
    fetchIotRecords().then(setRecords).catch(console.error)
  },[])

  useEffect(()=>{
    if(activeTab==='chart'&&records.length) setTimeout(()=>buildCharts(records),50)
  },[activeTab])

  function buildCharts(data){
    if(!window.Chart)return
    const Ch=window.Chart
    const toHourLabel=t=>{ const m=String(t||'').match(/(\d{1,2}):/); return m?`${m[1]}시`:t }
    let lastHour=null
    const labels=data.map(r=>{ const h=toHourLabel(r.time_start); if(h===lastHour)return ''; lastHour=h; return h })
    const legend={position:'top',labels:{color:'#fff'}}
    const axisColor='#fff'
    const scales={ x:{ ticks:{color:axisColor} }, y:{ ticks:{color:axisColor} } }
    const lineScales={ x:{ ticks:{color:axisColor,autoSkip:false,maxRotation:0,minRotation:0} }, y:{ ticks:{color:axisColor} } }
    const cfg=(l1,d1,l2,d2,c1,c2)=>({type:'line',data:{labels,datasets:[
      {label:l1,data:d1,borderColor:c1,tension:0.3,pointRadius:2},
      {label:l2,data:d2,borderColor:c2,tension:0.3,pointRadius:2}
    ]},options:{responsive:true,plugins:{legend},scales:lineScales}})
    Object.keys(cInst.current).forEach(k=>cInst.current[k]?.destroy())
    if(cRefs.cur.current) cInst.current.cur=new Ch(cRefs.cur.current,cfg('설정전류',data.map(r=>r.set_current),'출력전류',data.map(r=>r.out_current),'#4e9de0','#e04e4e'))
    if(cRefs.vol.current) cInst.current.vol=new Ch(cRefs.vol.current,cfg('설정전압',data.map(r=>r.set_voltage),'출력전압',data.map(r=>r.out_voltage),'#4ee0a0','#e0c04e'))
    const pieColors=['#4e9de0','#4ee0a0','#e0824e','#b266d6','#e0c04e','#e04e6e']
    const SHAPE_ORDER=['A-B','A-C','B-A','B-B','B-C']
    const sortShapes=keys=>[...keys].sort((a,b)=>{
      const ia=SHAPE_ORDER.indexOf(a), ib=SHAPE_ORDER.indexOf(b)
      if(ia===-1&&ib===-1)return a.localeCompare(b)
      if(ia===-1)return 1
      if(ib===-1)return -1
      return ia-ib
    })
    const pctLabelPlugin={ id:'pctLabel', afterDraw(chart){
      const meta=chart.getDatasetMeta(0)
      const vals=chart.data.datasets[0].data
      const total=vals.reduce((a,b)=>a+b,0)
      const {ctx}=chart
      ctx.save(); ctx.fillStyle='#fff'; ctx.font='bold 13px sans-serif'
      ctx.textAlign='center'; ctx.textBaseline='middle'
      meta.data.forEach((arc,i)=>{
        if(!total)return
        const {x,y}=arc.tooltipPosition()
        ctx.fillText((vals[i]/total*100).toFixed(1)+'%',x,y)
      })
      ctx.restore()
    }}
    if(cRefs.cel.current){ const c={};data.forEach(r=>{c[r.cell_shape]=(c[r.cell_shape]||0)+1})
      const celLabels=sortShapes(Object.keys(c))
      cInst.current.cel=new Ch(cRefs.cel.current,{type:'doughnut',data:{labels:celLabels,datasets:[{data:celLabels.map(k=>c[k]),backgroundColor:pieColors,borderWidth:0}]},
        options:{responsive:true,maintainAspectRatio:false,plugins:{legend:{position:'right',labels:{color:'#fff'}}}},
        plugins:[pctLabelPlugin]}) }
    const barLabelPlugin={ id:'barLabel', afterDraw(chart){
      const meta=chart.getDatasetMeta(0)
      const vals=chart.data.datasets[0].data
      const {ctx}=chart
      ctx.save(); ctx.fillStyle='#fff'; ctx.font='bold 13px sans-serif'
      ctx.textAlign='center'; ctx.textBaseline='middle'
      meta.data.forEach((bar,i)=>{
        const {x,y}=bar.getCenterPoint()
        ctx.fillText(vals[i].toFixed(1)+'mm',x,y)
      })
      ctx.restore()
    }}
    if(cRefs.sec.current){ const s={},cnt={};data.forEach(r=>{s[r.cell_shape]=(s[r.cell_shape]||0)+parseFloat(r.weld_length_rec||0);cnt[r.cell_shape]=(cnt[r.cell_shape]||0)+1})
      const secLabels=sortShapes(Object.keys(s))
      cInst.current.sec=new Ch(cRefs.sec.current,{type:'bar',data:{labels:secLabels,datasets:[{data:secLabels.map(k=>s[k]/cnt[k]),backgroundColor:'#4e9de0'}]},
        options:{responsive:true,plugins:{legend:{display:false}},scales},
        plugins:[barLabelPlugin]}) }
  }

  const TABS=[{id:'profile',label:'🗂 데이터 파일'},{id:'detail',label:'📋 용접 상세 기록'},{id:'chart',label:'📊 차트 분석'}]

  return(<>
    <PageHeader title="Row Data 파일 관리">
      <input type="checkbox" defaultChecked />중조 <input type="checkbox" />소조
    </PageHeader>
    <div className="iot-root">
      <div className="iot-tabbar">
        {TABS.map(t=>(<button key={t.id} className={`iot-tab${activeTab===t.id?' active':''}`} onClick={()=>setActiveTab(t.id)}>{t.label}</button>))}
      </div>
      {activeTab==='profile' && (<div className="iot-pane active">
        <DataTable rowData={files} columnDefs={FILE_COLS} height="100%" />
      </div>)}
      {activeTab==='detail' && (<div className="iot-pane active">
        {summary && (<div className="iot-summary-grid">
          {[['가동시간',summary.operation_time],['아크시간',summary.arc_time],['아크율',summary.arc_rate+'%',true],['용접장',summary.weld_length+'m',true],
            ['호선',summary.vessel_no],['블록',summary.block],['Assy',summary.assy],['작업자',summary.worker]].map(([l,v,hl])=>(
            <div key={l} className={`iot-summary-card${hl?' iot-summary-highlight':''}`}>
              <span className="iot-summary-label">{l}</span><span className="iot-summary-value">{v}</span>
            </div>
          ))}</div>)}
        <div className="iot-detail-table-wrap">
          <DataTable rowData={records} columnDefs={REC_COLS} height="100%" />
        </div>
      </div>)}
      {activeTab==='chart' && (<div className="iot-pane active">
        <div className="iot-chart-pane-inner">
          {[['설정/출력 전류(A)',cRefs.cur],['설정/출력 전압(V)',cRefs.vol],['셀 타입별 용접횟수',cRefs.cel],['타입별 평균 용접장(mm)',cRefs.sec]].map(([title,ref])=>(
            <div key={title} className="iot-chart-block">
              <div className="iot-chart-title">{title}</div>
              <div className="iot-canvas-wrap"><canvas ref={ref} /></div>
            </div>
          ))}
        </div>
      </div>)}
    </div>
  </>)
}
