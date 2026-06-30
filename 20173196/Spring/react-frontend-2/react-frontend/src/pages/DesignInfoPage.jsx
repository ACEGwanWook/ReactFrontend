import { useEffect, useState } from 'react'
import PageHeader from '../components/PageHeader'
import DataTable from '../components/DataTable'
import { fetchCellInfo, insertCellInfo, updateCellInfo, deleteCellInfo } from '../api'

const emptyForm = { ProjNo:'', BlockName:'', AssyName:'' }
const COLS = [
  { headerName:'No',        valueGetter:'node.rowIndex+1',              width:60  },
  { headerName:'호선번호',   field:'projNo',          flex:1 },
  { headerName:'블록',       field:'blockName',       flex:1 },
  { headerName:'ASSY',       field:'assyName',        flex:1 },
  { headerName:'데이터파일', field:'cellDataFileName', flex:2 },
  { headerName:'작성일',     field:'cellDataDateTime', flex:1,
    valueFormatter:p=>p.value?p.value.substring(0,10):'' },
  { headerName:'파일경로',   field:'cellDataFolder',  flex:2 },
]

export default function DesignInfoPage() {
  const [cellList,setCellList]=useState([])
  const [form,setForm]=useState(emptyForm)
  const [selected,setSelected]=useState(null)
  const [process,setProcess]=useState({소조:false,중조:true})

  const reload=()=>fetchCellInfo().then(setCellList).catch(console.error)
  const search=()=>fetchCellInfo({projNo:form.ProjNo,blockName:form.BlockName,assyName:form.AssyName}).then(setCellList).catch(console.error)
  useEffect(()=>{ reload() },[])

  function onRow(c){ setSelected(c); setForm({ProjNo:c.projNo,BlockName:c.blockName,AssyName:c.assyName}) }
  const f=field=>({ value:form[field]||'', onChange:e=>setForm(p=>({...p,[field]:e.target.value})) })

  async function handleInsert(){ await insertCellInfo(form); alert('✅ 등록'); reload() }
  async function handleUpdate(){ if(!selected)return alert('수정할 항목을 선택하세요.')
    await updateCellInfo({...form,cellID:selected.cellID}); alert('✅ 수정'); reload() }
  async function handleDelete(){ if(!selected)return alert('삭제할 항목을 선택하세요.')
    await deleteCellInfo(selected.cellID); alert('🗑 삭제'); reload(); setSelected(null); setForm(emptyForm) }

  return(<>
    <PageHeader title="도면 및 데이터 관리 (종조 Cell)">
      <button onClick={search}>검색</button>
      <button onClick={handleInsert}>신규</button>
      <button onClick={handleUpdate}>저장</button>
      <button onClick={handleDelete}>삭제</button>
    </PageHeader>
    <div className="flex formstyle">
      <label className="width20 flex"><span>호선번호</span><input className="formtext" {...f('ProjNo')} /></label>
      <label className="width20 flex"><span>블록명</span><input className="formtext" {...f('BlockName')} /></label>
      <label className="width20 flex"><span>ASSY</span><input className="formtext" {...f('AssyName')} /></label>
      <div className="flex" style={{gap:8}}>
        <label><input type="checkbox" checked={process.소조} onChange={e=>setProcess(p=>({...p,소조:e.target.checked}))} />소조</label>
        <label><input type="checkbox" checked={process.중조} onChange={e=>setProcess(p=>({...p,중조:e.target.checked}))} />중조</label>
      </div>
    </div>
    <DataTable rowData={cellList} columnDefs={COLS} onRowClicked={onRow} height={560} />
  </>)
}
