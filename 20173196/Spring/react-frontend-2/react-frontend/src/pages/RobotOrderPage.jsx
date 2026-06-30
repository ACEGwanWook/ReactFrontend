import { useEffect, useState } from 'react'
import PageHeader from '../components/PageHeader'
import DataTable from '../components/DataTable'

const COLS = [
  { headerName:'No',       valueGetter:'node.rowIndex+1', width:55 },
  { headerName:'로봇번호', field:'equipNum',       flex:1 },
  { headerName:'오더일자', field:'orderDate',      flex:1 },
  { headerName:'오더번호', field:'orderNum',       flex:1 },
  { headerName:'작업호선', field:'workLine',       flex:1 },
  { headerName:'작업블럭', field:'workBlock',      flex:1 },
  { headerName:'ASSY',     field:'assyName',       flex:1 },
  { headerName:'Bay',      valueGetter:()=>'4번 Bay', width:80 },
  { headerName:'총가동구간', valueGetter:()=>'100', width:90 },
  { headerName:'비가동구간', valueGetter:()=>'15',  width:90 },
  { headerName:'예상공수',  valueGetter:()=>'3',   width:80 },
  { headerName:'실적공수', field:'performanceNum', flex:1 },
  { headerName:'작업내용', field:'workDetail',     flex:2 },
  { headerName:'작업담당', field:'workAdmin',      flex:1 },
  { headerName:'작업시작', field:'workStart',      flex:1 },
  { headerName:'작업완료', field:'workEnd',        flex:1 },
  { headerName:'완료여부', field:'finish',         width:80 },
]

export default function RobotOrderPage() {
  const [data,setData]=useState([])
  const [filter,setFilter]=useState({ startDate:'', endDate:'', equipNum:'', finish:'전체' })
  const [process,setProcess]=useState({소조:false,중조:true})

  function load(params={}){
    const qs=new URLSearchParams(params).toString()
    fetch(`/api/robot-orders${qs?'?'+qs:''}`).then(r=>r.json()).then(setData).catch(console.error)
  }
  useEffect(()=>{ load() },[])

  function handleSearch(){
    const p={}
    if(filter.startDate) p.startDate=filter.startDate
    if(filter.endDate)   p.endDate=filter.endDate
    if(filter.equipNum)  p.equipNum=filter.equipNum
    if(filter.finish!=='전체') p.finish=filter.finish
    load(p)
  }
  const sf=field=>e=>setFilter(p=>({...p,[field]:e.target.value}))
  function onRow(r){ setFilter(p=>({...p,startDate:r.orderDate||'',endDate:r.workEnd||'',equipNum:r.equipNum||'',finish:r.finish||'전체'})) }

  return(<>
    <PageHeader title="용접 로봇/휴먼 배원 관리">
      <label><input type="checkbox" checked={process.소조} onChange={e=>setProcess(p=>({...p,소조:e.target.checked}))} />소조</label>
      <label><input type="checkbox" checked={process.중조} onChange={e=>setProcess(p=>({...p,중조:e.target.checked}))} />중조</label>
      <button onClick={handleSearch}>검색</button>
    </PageHeader>
    <div className="flex formstyle">
      <label className="width50 flex"><span>오더일자</span>
        <input type="date" className="formtext" value={filter.startDate} onChange={sf('startDate')} />
        &nbsp;~&nbsp;
        <input type="date" className="formtext" value={filter.endDate} onChange={sf('endDate')} />
      </label>
      <label className="width25 flex"><span>로봇번호</span><input type="text" className="formtext" value={filter.equipNum} onChange={sf('equipNum')} /></label>
      <label className="width25 flex"><span>완료여부</span>
        <select className="formtext" value={filter.finish} onChange={sf('finish')}>
          <option>전체</option><option>Y</option><option>N</option>
        </select>
      </label>
    </div>
    <DataTable rowData={data} columnDefs={COLS} onRowClicked={onRow} height={560} />
  </>)
}
