import { useEffect, useState } from 'react'
import PageHeader from '../components/PageHeader'
import DataTable from '../components/DataTable'
import { fetchUsers, fetchGrades, insertUser, updateUser, deleteUser } from '../api'

const emptyForm = { EmployeeNumber:'',UserName:'',GroupName:'',DepartName:'',SectionName:'',TeamName:'',HireDate:'',Position:'',Grade:'' }

const COLS = [
  { headerName:'사번',   field:'employeeNumber', flex:1 },
  { headerName:'이름',   field:'userName',       flex:1 },
  { headerName:'회사명', field:'groupName',      flex:1 },
  { headerName:'부서명', field:'departName',     flex:1 },
  { headerName:'과명',   field:'sectionName',    flex:1 },
  { headerName:'파트명', field:'teamName',       flex:1 },
  { headerName:'입사일', field:'hireDate',       flex:1 },
  { headerName:'직급',   field:'position',       flex:1 },
  { headerName:'직책',   field:'grade',          flex:1 },
]

export default function RobotResourcePage() {
  const [userList,setUserList]=useState([])
  const [grades,setGrades]=useState([])
  const [form,setForm]=useState(emptyForm)

  const reload=()=>fetchUsers().then(setUserList).catch(console.error)
  const search=()=>fetchUsers({
    employeeNumber:form.EmployeeNumber, userName:form.UserName, groupName:form.GroupName,
    departName:form.DepartName, sectionName:form.SectionName, teamName:form.TeamName,
    hireDate:form.HireDate, position:form.Position, grade:form.Grade,
  }).then(setUserList).catch(console.error)
  useEffect(()=>{ reload(); fetchGrades().then(setGrades).catch(console.error) },[])

  function onRow(u){ setForm({EmployeeNumber:u.employeeNumber,UserName:u.userName,GroupName:u.groupName,
    DepartName:u.departName,SectionName:u.sectionName,TeamName:u.teamName,HireDate:u.hireDate,Position:u.position,Grade:u.grade}) }

  const f=field=>({ value:form[field]||'', onChange:e=>setForm(p=>({...p,[field]:e.target.value})) })

  async function handleInsert(){ await insertUser(form); alert('✅ 등록되었습니다.'); reload() }
  async function handleUpdate(){ await updateUser(form); alert('✅ 수정되었습니다.'); reload() }
  async function handleDelete(){ if(!form.EmployeeNumber)return alert('삭제할 사원을 선택하세요.')
    await deleteUser(form.EmployeeNumber); alert('🗑 삭제되었습니다.'); reload(); setForm(emptyForm) }

  return(<>
    <PageHeader title="사용자 관리">
      <button onClick={search}>검색</button>
      <button onClick={handleInsert}>신규</button>
      <button onClick={handleUpdate}>저장</button>
      <button onClick={handleDelete}>삭제</button>
    </PageHeader>
    <div className="flex formstyle">
      <label className="width25 flex"><span>사번</span><input className="formtext" {...f('EmployeeNumber')} /></label>
      <label className="width25 flex"><span>이름</span><input className="formtext" {...f('UserName')} /></label>
      <label className="width25 flex"><span>회사명</span><input className="formtext" {...f('GroupName')} /></label>
      <label className="width25 flex"><span>부서명</span><input className="formtext" {...f('DepartName')} /></label>
    </div>
    <div className="flex formstyle">
      <label className="width25 flex"><span>과명</span><input className="formtext" {...f('SectionName')} /></label>
      <label className="width25 flex"><span>파트명</span><input className="formtext" {...f('TeamName')} /></label>
      <label className="width25 flex"><span>입사일자</span><input type="date" className="formtext" {...f('HireDate')} /></label>
      <label className="width25 flex"><span>직급</span><input className="formtext" {...f('Position')} /></label>
    </div>
    <div className="flex formstyle">
      <label className="width25 flex"><span>직책</span>
        <select className="formtext" value={form.Grade} onChange={e=>setForm(p=>({...p,Grade:e.target.value}))}>
          <option value="">선택</option>
          {grades.map(g=><option key={g.etc1} value={g.etc1}>{g.etc1}</option>)}
        </select>
      </label>
    </div>
    <DataTable rowData={userList} columnDefs={COLS} onRowClicked={onRow} height={560} />
  </>)
}
