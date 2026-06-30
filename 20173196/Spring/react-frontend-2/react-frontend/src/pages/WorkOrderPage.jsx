import { useEffect, useState } from 'react'
import PageHeader from '../components/PageHeader'
import DataTable from '../components/DataTable'
import { fetchWorkOrders, fetchProjNos, insertWorkOrder, updateWorkOrder, deleteWorkOrder } from '../api'

const emptyForm = { OrderDate:'',ProdActID:'',Bay:'',EquipNum:'',ProjNo:'',BlockName:'',AssyName:'',EmployeeNumber:'',AIperf:'',performanceNum:'',FinishDate:'',Finish:'전체' }
const COLS = [
  { headerName:'No',       valueGetter:'node.rowIndex+1', width:55 },
  { headerName:'오더일자', field:'orderDate',   flex:1 },
  { headerName:'오더번호', field:'orderNum',    flex:1 },
  { headerName:'작업호선', field:'workLine',    flex:1 },
  { headerName:'작업블럭', field:'workBlock',   flex:1 },
  { headerName:'ASSY',     field:'assyName',    flex:1 },
  { headerName:'Bay',      valueGetter:()=>'4번 Bay', width:80 },
  { headerName:'로봇No',   field:'equipNum',    flex:1 },
  { headerName:'작업담당', field:'workAdmin',   flex:1 },
  { headerName:'작업내용', field:'workDetail',  flex:2 },
  { headerName:'AI공수',   field:'aiact',       flex:1 },
  { headerName:'실적공수', field:'performanceNum', flex:1 },
  { headerName:'완료일자', field:'workEnd',     flex:1 },
  { headerName:'완료여부', field:'finish',      width:80 },
]

export default function WorkOrderPage() {
  const [workOrders,setWorkOrders]=useState([])
  const [projNos,setProjNos]=useState([])
  const [form,setForm]=useState(emptyForm)
  const [process,setProcess]=useState({소조:false,중조:true})

  const reload=()=>fetchWorkOrders().then(setWorkOrders).catch(console.error)
  const search=()=>fetchWorkOrders({
    orderDate:form.OrderDate, orderNum:form.ProdActID, equipNum:form.EquipNum, workLine:form.ProjNo,
    workBlock:form.BlockName, assyName:form.AssyName, workAdmin:form.EmployeeNumber, aiact:form.AIperf,
    performanceNum:form.performanceNum, workEnd:form.FinishDate, finish:form.Finish,
  }).then(setWorkOrders).catch(console.error)
  useEffect(()=>{ reload(); fetchProjNos().then(setProjNos).catch(console.error) },[])

  function onRow(wo){ setForm({OrderDate:wo.orderDate,ProdActID:wo.orderNum,Bay:'',EquipNum:wo.equipNum,
    ProjNo:wo.workLine,BlockName:wo.workBlock,AssyName:wo.assyName,EmployeeNumber:wo.workAdmin,
    AIperf:wo.aiact,performanceNum:wo.performanceNum,FinishDate:wo.workEnd,Finish:wo.finish}) }
  const f=field=>({ value:form[field]||'', onChange:e=>setForm(p=>({...p,[field]:e.target.value})) })

  function toDTO(f){ return {
    OrderNum:f.ProdActID, OrderDate:f.OrderDate, WorkLine:f.ProjNo, WorkBlock:f.BlockName,
    AssyName:f.AssyName, EquipNum:f.EquipNum, WorkAdmin:f.EmployeeNumber, PerformanceNum:f.performanceNum,
    Aiact:f.AIperf, WorkEnd:f.FinishDate, Finish:f.Finish, WorkStart:f.OrderDate,
  } }
  async function handleInsert(){
    if(!form.ProjNo) return alert('작업호선을 선택하세요.')
    const prefix=form.ProjNo.replace(/[.*+?^${}()|[\]\\]/g,'\\$&')
    const re=new RegExp(`^${prefix}_(\\d+)$`)
    const nums=workOrders.filter(w=>w.workLine===form.ProjNo).map(w=>{
      const m=String(w.orderNum||'').match(re)
      return m?parseInt(m[1],10):0
    })
    const next=nums.length?Math.max(...nums)+1:1
    const orderNum=`${form.ProjNo}_${next}`
    try{ await insertWorkOrder(toDTO({...form,ProdActID:orderNum})); alert('✅ 등록'); reload() }catch(e){alert(e.message)}
  }
  async function handleUpdate(){ try{ await updateWorkOrder(toDTO(form)); alert('✅ 수정'); reload() }catch(e){alert(e.message)} }
  async function handleDelete(){ if(!form.ProdActID)return alert('삭제할 항목을 선택하세요.')
    try{ await deleteWorkOrder(form.ProdActID); alert('🗑 삭제'); reload(); setForm(emptyForm) }catch(e){alert(e.message)} }

  const uniqueEquip=[...new Set(workOrders.map(w=>w.equipNum).filter(Boolean))]
  const uniqueBlock=[...new Set(workOrders.map(w=>w.workBlock).filter(Boolean))]
  const uniqueAssy =[...new Set(workOrders.map(w=>w.assyName).filter(Boolean))]

  return(<>
    <PageHeader title="워크 오더 관리">
      <label><input type="checkbox" checked={process.소조} onChange={e=>setProcess(p=>({...p,소조:e.target.checked}))} />소조</label>
      <label><input type="checkbox" checked={process.중조} onChange={e=>setProcess(p=>({...p,중조:e.target.checked}))} />중조</label>
      <button onClick={search}>검색</button>
      <button onClick={handleInsert}>신규</button>
      <button onClick={handleUpdate}>저장</button>
      <button onClick={handleDelete}>삭제</button>
    </PageHeader>
    <div className="flex formstyle">
      <label className="width25 flex"><span>오더일자</span><input type="date" className="formtext" {...f('OrderDate')} /></label>
      <label className="width25 flex"><span>오더번호</span><input className="formtext" readOnly {...f('ProdActID')} /></label>
      <label className="width25 flex"><span>Bay</span><input className="formtext" {...f('Bay')} /></label>
      <label className="width25 flex"><span>로봇번호</span>
        <select className="formtext" value={form.EquipNum} onChange={e=>setForm(p=>({...p,EquipNum:e.target.value}))}>
          <option value="">선택</option>{uniqueEquip.map(e=><option key={e}>{e}</option>)}
        </select>
      </label>
    </div>
    <div className="flex formstyle">
      <label className="width25 flex"><span>작업호선</span>
        <select className="formtext" value={form.ProjNo} onChange={e=>setForm(p=>({...p,ProjNo:e.target.value}))}>
          <option value="">선택</option>{projNos.map(p=><option key={p.workLine} value={p.workLine}>{p.workLine}</option>)}
        </select>
      </label>
      <label className="width25 flex"><span>작업블럭</span>
        <select className="formtext" value={form.BlockName} onChange={e=>setForm(p=>({...p,BlockName:e.target.value}))}>
          <option value="">선택</option>{uniqueBlock.map(b=><option key={b}>{b}</option>)}
        </select>
      </label>
      <label className="width25 flex"><span>ASS'Y</span>
        <select className="formtext" value={form.AssyName} onChange={e=>setForm(p=>({...p,AssyName:e.target.value}))}>
          <option value="">선택</option>{uniqueAssy.map(a=><option key={a}>{a}</option>)}
        </select>
      </label>
      <label className="width25 flex"><span>작업담당</span><input className="formtext" {...f('EmployeeNumber')} /></label>
    </div>
    <div className="flex formstyle">
      <label className="width25 flex"><span>AI공수</span><input className="formtext" {...f('AIperf')} /></label>
      <label className="width25 flex"><span>실적공수</span><input className="formtext" {...f('performanceNum')} /></label>
      <label className="width25 flex"><span>완료일자</span><input type="date" className="formtext" {...f('FinishDate')} /></label>
      <label className="width25 flex"><span>완료여부</span>
        <select className="formtext" value={form.Finish} onChange={e=>setForm(p=>({...p,Finish:e.target.value}))}>
          <option>전체</option><option>Y</option><option>N</option>
        </select>
      </label>
    </div>
    <DataTable rowData={workOrders} columnDefs={COLS} onRowClicked={onRow} height={560} />
  </>)
}
