import { useEffect, useState } from 'react'
import PageHeader from '../components/PageHeader'
import DataTable from '../components/DataTable'
import { fetchGroupCounts, fetchCodesByGroup, insertCode, updateCode, deleteCode } from '../api'

const emptyForm = { groupCode:'', groupName:'', code:'', codeName:'', etc1:'', etc2:'', useYn:false }

const GROUP_COLS = [
  { headerName:'그룹명',  field:'groupName', flex:2 },
  { headerName:'코드수',  field:'count',     flex:1 },
]
const DETAIL_COLS = [
  { headerName:'코드',   field:'code',     flex:1 },
  { headerName:'코드명', field:'codeName', flex:2 },
  { headerName:'비고1',  field:'etc1',     flex:1 },
  { headerName:'비고2',  field:'etc2',     flex:1 },
  { headerName:'사용',   field:'useYn',    flex:1 },
]

export default function CommonCodePage() {
  const [groups,setGroups]=useState([])
  const [details,setDetails]=useState([])
  const [selectedGroup,setSelectedGroup]=useState(null)
  const [form,setForm]=useState(emptyForm)
  const [msg,setMsg]=useState('')

  useEffect(()=>{ fetchGroupCounts().then(setGroups).catch(console.error) },[])

  function onGroupRow(g){
    setSelectedGroup(g)
    setForm(f=>({...f,groupCode:g.groupCode,groupName:g.groupName}))
    fetchCodesByGroup(g.groupName).then(setDetails).catch(console.error)
  }
  function onDetailRow(d){
    setForm({groupCode:selectedGroup?.groupCode||'',groupName:selectedGroup?.groupName||'',
      code:d.code,codeName:d.codeName,etc1:d.etc1||'',etc2:d.etc2||'',useYn:d.useYn==='공통'})
  }

// 수정 — catch에서 에러 메시지 표시
async function handleInsert() {
  if (!form.code || !form.codeName) return alert('코드와 코드명을 입력하세요.')
  if (!selectedGroup) return alert('좌측에서 그룹을 먼저 선택하세요.')
  try {
    await insertCode({ ...form, useYn: form.useYn ? '공통' : '' })
    setMsg('✅ 코드가 등록되었습니다.')
    fetchCodesByGroup(selectedGroup.groupName).then(setDetails)
  } catch (e) {
    alert(e.message)   // ← "해당 코드가 이미 존재합니다." 표시
  }
}
  async function handleUpdate(){ await updateCode({...form,useYn:form.useYn?'공통':''}); fetchCodesByGroup(selectedGroup.groupName).then(setDetails) }
  async function handleDelete(){ if(!form.code)return alert('삭제할 코드를 선택하세요.')
    await deleteCode(form.code); fetchCodesByGroup(selectedGroup.groupName).then(setDetails); setForm(emptyForm) }

  const f=field=>({ value:form[field], onChange:e=>setForm(p=>({...p,[field]:e.target.value})) })

  return(<>
    <PageHeader title="공통코드관리">
      <button onClick={handleInsert}>신규</button>
      <button onClick={handleUpdate}>저장</button>
      <button onClick={handleDelete}>삭제</button>
    </PageHeader>
    {msg && <div style={{color:'#1a7f37',padding:'4px 0'}}>{msg}</div>}
    <div className="flex formstyle">
      <label className="width25 flex"><span>그룹코드</span><input className="formtext readonly" readOnly {...f('groupCode')} /></label>
      <label className="width25 flex"><span>그룹명</span><input className="formtext readonly" readOnly {...f('groupName')} /></label>
      <label className="width25 flex"><span>코드</span><input className="formtext" {...f('code')} /></label>
      <label className="width25 flex"><span>코드명</span><input className="formtext" {...f('codeName')} /></label>
    </div>
    <div className="flex formstyle">
      <label className="width25 flex"><span>비고1</span><input className="formtext" {...f('etc1')} /></label>
      <label className="width25 flex"><span>비고2</span><input className="formtext" {...f('etc2')} /></label>
      <label className="width25 flex"><span>사용유무</span>
        <input type="checkbox" checked={form.useYn} onChange={e=>setForm(p=>({...p,useYn:e.target.checked}))} /> YES
      </label>
    </div>
    <div className="flex width100" style={{gap:8}}>
      <div style={{width:'30%'}}>
        <DataTable rowData={groups} columnDefs={GROUP_COLS} onRowClicked={onGroupRow} height={560} pageSize={30} />
      </div>
      <div style={{flex:1}}>
        <DataTable rowData={details} columnDefs={DETAIL_COLS} onRowClicked={onDetailRow} height={560} pageSize={30} />
      </div>
    </div>
  </>)
}
