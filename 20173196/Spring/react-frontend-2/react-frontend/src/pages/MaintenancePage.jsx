import { useEffect, useState } from 'react'
import PageHeader from '../components/PageHeader'
import DataTable from '../components/DataTable'
import { fetchRobotErrors, fetchRepairs, fetchRobotNos, fetchErrorReasons, fetchRepairParts,
  insertRobotError, updateRobotError, deleteRobotError, insertRepair, updateRepair, deleteRepair } from '../api'

const emptyErr = { ErrNum:'', ErrReason:'', ErrDetail:'' }
const emptyRep = { RepairNo:'', RepairDateTime:'', RepairPart:'', RepairCost:'', RepairDesc:'' }

const ERR_COLS = [
  { headerName:'No',       valueGetter:'node.rowIndex+1', width:60 },
  { headerName:'장비명',   field:'robotNum',     flex:1 },
  { headerName:'고장일자', field:'errorDate',    flex:1 },
  { headerName:'고장사유', field:'errorReason',  flex:2 },
  { headerName:'고장내용', field:'errorDetail',  flex:2 },
  { headerName:'파일여부', field:'file',         flex:1 },
]
const REP_COLS = [
  { headerName:'No',       valueGetter:'node.rowIndex+1', width:60 },
  { headerName:'장비명',   field:'robotNum',      flex:1 },
  { headerName:'수선순번', field:'receiveNum',    flex:1 },
  { headerName:'수선일자', field:'receiveDate',   flex:1 },
  { headerName:'수선부품', field:'receivePart',   flex:1 },
  { headerName:'수선비용', field:'receiveCost',   flex:1 },
  { headerName:'수선내용', field:'receiveDetail', flex:2 },
  { headerName:'파일여부', field:'file',          flex:1 },
]

export default function MaintenancePage() {
  const [activeTab,setActiveTab]=useState('error')
  const [robotNos,setRobotNos]=useState([])
  const [errorReasons,setErrorReasons]=useState([])
  const [repairParts,setRepairParts]=useState([])
  const [selectedRobot,setSelectedRobot]=useState('')
  const [errors,setErrors]=useState([])
  const [repairs,setRepairs]=useState([])
  const [errForm,setErrForm]=useState(emptyErr)
  const [repForm,setRepForm]=useState(emptyRep)

  useEffect(()=>{
    fetchRobotNos().then(setRobotNos).catch(console.error)
    fetchErrorReasons().then(setErrorReasons).catch(console.error)
    fetchRepairParts().then(setRepairParts).catch(console.error)
    fetchRobotErrors({}).then(setErrors).catch(console.error)
    fetchRepairs({}).then(setRepairs).catch(console.error)
  },[])

  const reloadErrors=()=>fetchRobotErrors({robotNum:selectedRobot}).then(setErrors).catch(console.error)
  const reloadRepairs=()=>fetchRepairs({robotNum:selectedRobot}).then(setRepairs).catch(console.error)
  const searchErrors=()=>fetchRobotErrors({robotNum:selectedRobot,errNum:errForm.ErrNum,reason:errForm.ErrReason,detail:errForm.ErrDetail}).then(setErrors).catch(console.error)
  const searchRepairs=()=>fetchRepairs({robotNum:selectedRobot,repairNo:repForm.RepairNo,date:repForm.RepairDateTime,part:repForm.RepairPart,cost:repForm.RepairCost,desc:repForm.RepairDesc}).then(setRepairs).catch(console.error)

  function onErrRow(e){ setErrForm({ErrNum:e.errorNum,ErrReason:e.errorReason,ErrDetail:e.errorDetail}) }
  function onRepRow(r){ setRepForm({RepairNo:r.receiveNum,RepairDateTime:r.receiveDate,RepairPart:r.receivePart,RepairCost:r.receiveCost,RepairDesc:r.receiveDetail}) }

  async function errSave(){ try{
    errForm.ErrNum ? await updateRobotError({...errForm,robotNum:selectedRobot}) : await insertRobotError({...errForm,robotNum:selectedRobot})
    alert('✅ 저장'); reloadErrors()
  }catch(e){alert(e.message)}}
  async function errDelete(){ if(!errForm.ErrNum)return alert('삭제할 항목을 선택하세요.')
    await deleteRobotError(errForm.ErrNum); alert('🗑 삭제'); reloadErrors(); setErrForm(emptyErr) }
  async function repSave(){ try{
    repForm.RepairNo ? await updateRepair({...repForm,robotNum:selectedRobot}) : await insertRepair({...repForm,robotNum:selectedRobot})
    alert('✅ 저장'); reloadRepairs()
  }catch(e){alert(e.message)}}
  async function repDelete(){ if(!repForm.RepairNo)return alert('삭제할 항목을 선택하세요.')
    await deleteRepair(repForm.RepairNo); alert('🗑 삭제'); reloadRepairs(); setRepForm(emptyRep) }

  const isErr=activeTab==='error'
  return(<>
    <PageHeader title="용접로봇 고장 이력 관리">
      <button onClick={isErr?searchErrors:searchRepairs}>검색</button>
      <button onClick={isErr?()=>setErrForm(emptyErr):()=>setRepForm(emptyRep)}>신규</button>
      <button onClick={isErr?errSave:repSave}>저장</button>
      <button onClick={isErr?errDelete:repDelete}>삭제</button>
    </PageHeader>
    <div className="flex formstyle">
      <label className="width25 flex"><span>로봇번호</span>
        <select className="formtext" value={selectedRobot} onChange={e=>setSelectedRobot(e.target.value)}>
          <option value="">선택</option>
          {robotNos.map(r=><option key={r.robotNum} value={r.robotNum}>{r.robotNum}</option>)}
        </select>
      </label>
      {isErr && <label className="width25 flex"><span>고장순번</span>
        <input className="formtext" value={errForm.ErrNum} onChange={e=>setErrForm(p=>({...p,ErrNum:e.target.value}))} />
      </label>}
    </div>
    <div className="errorbuttondiv">
      <button className={`error${isErr?' active':''}`} onClick={()=>setActiveTab('error')}>고장관리</button>
      <button className={`receive${!isErr?' active':''}`} onClick={()=>setActiveTab('repair')}>수선관리</button>
    </div>
    {isErr && (<div className="errordiv" style={{display:'block'}}>
      <div className="flex formstyle">
        <label className="width25 flex"><span>고장순번</span><input className="formtext" readOnly value={errForm.ErrNum} /></label>
        <label className="width25 flex"><span>고장사유</span>
          <select className="formtext" value={errForm.ErrReason} onChange={e=>setErrForm(p=>({...p,ErrReason:e.target.value}))}>
            <option value="">선택</option>
            {errorReasons.map((r,i)=><option key={r.errorReason||i} value={r.errorReason}>{r.errorReason}</option>)}
          </select>
        </label>
        <label className="width50 flex"><span>고장내용</span>
          <input className="formtext" value={errForm.ErrDetail} onChange={e=>setErrForm(p=>({...p,ErrDetail:e.target.value}))} />
        </label>
      </div>
      <DataTable rowData={errors} columnDefs={ERR_COLS} onRowClicked={onErrRow} height={480} />
    </div>)}
    {!isErr && (<div className="receivediv" style={{display:'block'}}>
      <div className="flex formstyle">
        <label className="width25 flex"><span>수선순번</span><input className="formtext" value={repForm.RepairNo} onChange={e=>setRepForm(p=>({...p,RepairNo:e.target.value}))} /></label>
        <label className="width25 flex"><span>수선일자</span><input type="date" className="formtext" value={repForm.RepairDateTime} onChange={e=>setRepForm(p=>({...p,RepairDateTime:e.target.value}))} /></label>
        <label className="width25 flex"><span>수선부품</span>
          <select className="formtext" value={repForm.RepairPart} onChange={e=>setRepForm(p=>({...p,RepairPart:e.target.value}))}>
            <option value="">선택</option>
            {repairParts.map((r,i)=><option key={r.receivePart||i} value={r.receivePart}>{r.receivePart}</option>)}
          </select>
        </label>
        <label className="width25 flex"><span>수선비용</span><input className="formtext" value={repForm.RepairCost} onChange={e=>setRepForm(p=>({...p,RepairCost:e.target.value}))} /></label>
      </div>
      <div className="flex formstyle"><label className="flex receivecontent" style={{width:'100%'}}>
        <span>수선내용</span><input className="formtext" value={repForm.RepairDesc} onChange={e=>setRepForm(p=>({...p,RepairDesc:e.target.value}))} />
      </label></div>
      <DataTable rowData={repairs} columnDefs={REP_COLS} onRowClicked={onRepRow} height={480} />
    </div>)}
  </>)
}
