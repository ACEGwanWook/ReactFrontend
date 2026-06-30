import { useState } from 'react'
import PageHeader from '../components/PageHeader'
import DataTable from '../components/DataTable'

const TABLE_DATA = [
  {no:1,date:'2026-02-02',bay:'Bay3',line:'HL843206',block:'BL11',assy:'TT1',dueDate:'2025-02-05',time:'7시간'},
  {no:2,date:'2026-02-02',bay:'Bay2',line:'HL843206',block:'BL11',assy:'TT2',dueDate:'2025-02-05',time:'10시간'},
  {no:3,date:'2026-02-02',bay:'Bay1',line:'HL843206',block:'BL11',assy:'TT3',dueDate:'2025-02-06',time:'4시간'},
  {no:4,date:'2026-02-03',bay:'Bay3',line:'HL843206',block:'BL12',assy:'TT1',dueDate:'2025-02-06',time:'8시간'},
  {no:5,date:'2026-02-03',bay:'Bay4',line:'HL843206',block:'BL12',assy:'TT2',dueDate:'2025-02-06',time:'8시간'},
  {no:6,date:'2026-02-04',bay:'Bay4',line:'HL843206',block:'BL12',assy:'TT5',dueDate:'2025-02-09',time:'9시간'},
  {no:7,date:'2026-02-04',bay:'Bay3',line:'HL843206',block:'BL13',assy:'TT3',dueDate:'2025-02-09',time:'12시간'},
  {no:8,date:'2026-02-05',bay:'Bay1',line:'HL843206',block:'BL13',assy:'TT5',dueDate:'2025-02-10',time:'11시간'},
  {no:9,date:'2026-02-05',bay:'Bay3',line:'HL843206',block:'BL13',assy:'TT6',dueDate:'2025-02-10',time:'5시간'},
]
const CARDS = [
  {label:'Bay',value:'Bay3',bg:'blue'},{label:'대기',value:'30개',bg:'orange'},
  {label:'배치됨',value:'22개',bg:'orangered'},{label:'납기 입박',value:'6개',bg:'red'},
  {label:'평균 시간',value:'8.2시간',bg:'indigo'},
]
const COLS = [
  {headerName:'재공 번호',field:'no',      width:90},
  {headerName:'재공 일자',field:'date',    flex:1},
  {headerName:'Bay 번호', field:'bay',     flex:1},
  {headerName:'호선번호', field:'line',    flex:1},
  {headerName:'블록명',   field:'block',   flex:1},
  {headerName:'ASSY',    field:'assy',    flex:1},
  {headerName:'납기 예정일',field:'dueDate',flex:1},
  {headerName:'배치 시간',field:'time',   flex:1},
]

export default function DispatchWipPage() {
  const [filter,setFilter]=useState({date:'',bay:'',finish:'전체'})
  const [process,setProcess]=useState({소조:false,중조:true})
  const rows=TABLE_DATA.filter(d=>!filter.bay||d.bay.includes(filter.bay))
  const sf=field=>e=>setFilter(p=>({...p,[field]:e.target.value}))

  return(<>
    <PageHeader title="Bay 별 배치 및 생산 관리">
      <label><input type="checkbox" checked={process.소조} onChange={e=>setProcess(p=>({...p,소조:e.target.checked}))} />소조</label>
      <label><input type="checkbox" checked={process.중조} onChange={e=>setProcess(p=>({...p,중조:e.target.checked}))} />중조</label>
      <button>새로고침</button><button>검색</button><button>저장</button>
    </PageHeader>
    <div className="flex formstyle">
      <label className="width25 flex"><span>작업 일자 </span><input type="date" className="formtext" value={filter.date} onChange={sf('date')} /></label>
      <label className="width25 flex"><span>BAY </span><input type="text" className="formtext" value={filter.bay} onChange={sf('bay')} /></label>
      <label className="width25 flex"><span>배치여부 </span>
        <select className="formtext" value={filter.finish} onChange={sf('finish')}>
          <option>전체</option><option>배치</option><option>미배치</option>
        </select>
      </label>
    </div>
    <div className="flex" style={{marginTop:3}}>
      {CARDS.map(c=>(
        <div key={c.label} className="width20 flex-column datainfo" style={{backgroundColor:c.bg}}>
          <span>{c.label}</span><span style={{fontWeight:'bold',fontSize:16}}>{c.value}</span>
        </div>
      ))}
    </div>
    <DataTable rowData={rows} columnDefs={COLS} height={340} />
    <img src="/images/작업장Bay1.png" alt="작업장 Bay" style={{width:'calc(100% - 6px)',height:280,objectFit:'contain'}} />
  </>)
}
