import { useEffect, useState } from 'react'
import PageHeader from '../components/PageHeader'
import DataTable from '../components/DataTable'
import { fetchRobots, insertRobot, updateRobot, deleteRobot } from '../api'

const emptyForm = { RobotNo:'',RobotName:'',Maker:'',ModelName:'',SerialName:'',Weight:'',IntroDate:'',InspectDate:'',InspectCycle:'',Process:'' }
const CYCLES = Array.from({length:12},(_,i)=>`${i+1}개월`)
const COLS = [
  { headerName:'No',        valueGetter:'node.rowIndex+1', width:60,  sortable:false },
  { headerName:'로봇번호',   field:'robotNo',      flex:1 },
  { headerName:'로봇명',     field:'robotName',    flex:1 },
  { headerName:'Maker',     field:'maker',        flex:1 },
  { headerName:'모델명',     field:'modelName',    flex:1 },
  { headerName:'시리얼No',   field:'serialName',   flex:1 },
  { headerName:'중량(kg)',   field:'weight',       flex:1 },
  { headerName:'도입일자',   field:'introDate',    flex:1 },
  { headerName:'점검일자',   field:'inspectDate',  flex:1 },
  { headerName:'점검주기',   field:'inspectCycle', flex:1 },
  { headerName:'공정',       field:'robotType',    flex:1 },
]

export default function AutoAssetPage() {
  const [robots,setRobots]=useState([])
  const [form,setForm]=useState(emptyForm)
  const reload=()=>fetchRobots().then(setRobots).catch(console.error)
  const search=()=>fetchRobots({
    robotNo:form.RobotNo, robotName:form.RobotName, maker:form.Maker, modelName:form.ModelName,
    serialName:form.SerialName, weight:form.Weight, introDate:form.IntroDate,
    inspectDate:form.InspectDate, inspectCycle:form.InspectCycle, robotType:form.Process,
  }).then(setRobots).catch(console.error)
  useEffect(()=>{ reload() },[])

  function toProcess(robotType){
    if(!robotType) return ''
    if(robotType.startsWith('중조')) return '중조'
    if(robotType.startsWith('소조')) return '소조'
    return ''
  }
  function onRow(r){ setForm({RobotNo:r.robotNo,RobotName:r.robotName,Maker:r.maker,ModelName:r.modelName,
    SerialName:r.serialName,Weight:r.weight,IntroDate:r.introDate,InspectDate:r.inspectDate,InspectCycle:r.inspectCycle,Process:toProcess(r.robotType)}) }
  const f=field=>({ value:form[field]||'', onChange:e=>setForm(p=>({...p,[field]:e.target.value})) })

  async function handleInsert(){ try{ await insertRobot({...form,RobotType:form.Process}); alert('✅ 등록'); reload() }catch(e){alert(e.message)} }
  async function handleUpdate(){ try{ await updateRobot({...form,RobotType:form.Process}); alert('✅ 수정'); reload() }catch(e){alert(e.message)} }
  async function handleDelete(){ if(!form.RobotNo)return alert('삭제할 로봇을 선택하세요.')
    try{ await deleteRobot(form.RobotNo); alert('🗑 삭제'); reload(); setForm(emptyForm) }catch(e){alert(e.message)} }

  return(<>
    <PageHeader title="용접 로봇 자산 관리">
      <button onClick={search}>검색</button>
      <button onClick={handleInsert}>신규</button>
      <button onClick={handleUpdate}>저장</button>
      <button onClick={handleDelete}>삭제</button>
    </PageHeader>
    <div className="flex formstyle">
      <label className="width25 flex"><span>로봇번호</span><input type="number" className="formtext" {...f('RobotNo')} /></label>
      <label className="width25 flex"><span>로봇명</span><input className="formtext" {...f('RobotName')} /></label>
      <label className="width25 flex"><span>Maker</span><input className="formtext" {...f('Maker')} /></label>
      <label className="width25 flex"><span>모델명</span><input className="formtext" {...f('ModelName')} /></label>
    </div>
    <div className="flex formstyle">
      <label className="width25 flex"><span>시리얼No</span><input className="formtext" {...f('SerialName')} /></label>
      <label className="width25 flex"><span>중량(kg)</span><input className="formtext" {...f('Weight')} /></label>
      <label className="width25 flex"><span>도입일자</span><input type="date" className="formtext" {...f('IntroDate')} /></label>
      <label className="width25 flex"><span>점검일자</span><input type="date" className="formtext" {...f('InspectDate')} /></label>
    </div>
    <div className="flex formstyle">
      <label className="width25 flex"><span>점검주기</span>
        <select className="formtext" value={form.InspectCycle} onChange={e=>setForm(p=>({...p,InspectCycle:e.target.value}))}>
          <option value="">-</option>{CYCLES.map(c=><option key={c}>{c}</option>)}
        </select>
      </label>
      <label className="width25 flex"><span>공정</span>
        <select className="formtext" value={form.Process} onChange={e=>setForm(p=>({...p,Process:e.target.value}))}>
          <option value="">-</option><option>소조</option><option>중조</option>
        </select>
      </label>
    </div>
    <DataTable rowData={robots} columnDefs={COLS} onRowClicked={onRow} height={560} />
  </>)
}
