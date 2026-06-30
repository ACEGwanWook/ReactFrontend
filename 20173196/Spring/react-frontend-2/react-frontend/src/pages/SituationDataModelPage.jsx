import { useEffect, useState } from 'react'
import PageHeader from '../components/PageHeader'
import DataTable from '../components/DataTable'
import { fetchSituationModel } from '../api'

const COLS = [
  { headerName:'No',       valueGetter:'node.rowIndex+1', width:55 },
  { headerName:'호선명',   field:'projNo',        flex:1 },
  { headerName:'블록명',   field:'blockName',     flex:1 },
  { headerName:'ASSY',     field:'assyName',      flex:1 },
  { headerName:'Cell',     field:'cellNo',        width:70 },
  { headerName:'표준타입', field:'cellType',      flex:1 },
  { headerName:'Gap',      field:'gap',           flex:2 },
  { headerName:'로봇번호', field:'robotNo',       flex:1 },
  { headerName:'Bay',      valueGetter:()=>'4번 Bay', width:80 },
  { headerName:'시간',     field:'pictFileDateTime', flex:2 },
  { headerName:'작업자',   valueGetter:()=>'손관욱', flex:1 },
  { headerName:'최종판단', field:'tagUser',       flex:1 },
  { headerName:'Comment',  field:'qualityErrorDesc', flex:2 },
]

export default function SituationDataModelPage() {
  const [data,setData]=useState([])
  const [selected,setSelected]=useState(null)
  const [showModal,setShowModal]=useState(false)
  useEffect(()=>{ fetchSituationModel().then(rows=>{ setData(rows); if(rows.length>0)setSelected(rows[0]) }).catch(console.error) },[])
  const sel=selected||{}

  return(<>
    <PageHeader title="용접 Gap 칫수 산정 데이터 관리">
      <input type="checkbox" value="소조" />소조
      <input type="checkbox" value="중조" defaultChecked />중조
    </PageHeader>
    <div className="flex width100">
      <div className="flex reactivecolumn">
        <div className="flex-column imginfo"><span>용접 전 이미지</span><img className="weldimg" src="/images/cell7normal.png" alt="용접 전" /></div>
        <div className="flex-column imginfo"><span>Cell Gap</span><img className="weldimg" src="/images/CellGap1.png" alt="Gap" /></div>
      </div>
      <div className="flex-column width100">
        <div className="flex">
          {[['호선명',sel.projNo,'red'],['블록명',sel.blockName,'orange'],['ASSY',sel.assyName,'green'],['Cell No',sel.cellNo,'blue'],['표준타입',sel.cellType,'#003399']].map(([l,v,c])=>(
            <div key={l} className="width20 flex-column datainfo" style={{backgroundColor:c}}><span>{l}</span><span className="value">{v||'-'}</span></div>
          ))}
        </div>
        <div className="flex"><div className="width100 flex-column datainfo" style={{backgroundColor:'#003399'}}><span>Gap</span><span className="value">{sel.gap||'-'}</span></div></div>
        <div className="flex">
          {[['로봇번호',sel.robotNo,'red'],['Bay','4번 Bay','orangered'],['작업자','손관욱','orange'],['최종판단',sel.tagUser,'green']].map(([l,v,c])=>(
            <div key={l} className="width25 flex-column datainfo" style={{backgroundColor:c}}><span>{l}</span><span className="value">{v||'-'}</span></div>
          ))}
        </div>
        <div className="flex">
          <div className="width50 flex-column datainfo" style={{backgroundColor:'red'}}><span>시간</span><span className="value">{sel.pictFileDateTime||'-'}</span></div>
          <div className="width50 flex-column datainfo" style={{backgroundColor:'red'}}><span>Comment</span><span className="value">{sel.qualityErrorDesc||'-'}</span></div>
        </div>
      </div>
    </div>
    <DataTable rowData={data} columnDefs={COLS} onRowClicked={d=>{setSelected(d);setShowModal(true)}} height={280} />

    {showModal && sel.projNo && (
      <div style={{display:'flex',alignItems:'center',justifyContent:'center',position:'fixed',inset:0,zIndex:2000,background:'rgba(0,0,0,0.5)'}}
        onClick={e=>{ if(e.target===e.currentTarget)setShowModal(false) }}>
        <div className="SituationModel flex-column" style={{minWidth:520}}>
          <div className="topmenu justifybetween" style={{display:'flex',alignItems:'center',marginBottom:8}}>
            <span>데이터 상세정보</span>
            <button onClick={()=>setShowModal(false)}>x</button>
          </div>
          <span className="datacaption">{sel.projNo} / {sel.blockName} / {sel.assyName} / Cell {sel.cellNo}</span>
          <div className="flex">
            <div className="flex-column imginfo"><span>표준타입</span><img className="weldimg" src="/images/cell7normal.png" alt="" /></div>
            <div className="flex-column imginfo"><span>실제 결과</span><img className="weldimg" src="/images/cell7.png" alt="" /></div>
            <div className="flex-column imginfo"><span>Gap 측정</span>
              <span>X : <input type="text" className="formtext" defaultValue={5} /></span>
              <span>Y : <input type="text" className="formtext" defaultValue={10} /></span>
            </div>
          </div>
          <div className="flex ModelDataInfo formstyle">
            <label className="flex flex-column width33"><span>현재 로봇 관절 값</span><input type="text" className="formtext" defaultValue={sel.gap||''} /></label>
            <label className="flex flex-column width33"><span>현재 로봇 끝단 자세</span><input type="text" className="formtext" /></label>
            <label className="flex flex-column width33"><span>뎁스맵 데이터</span><input type="text" className="formtext" /></label>
          </div>
          <button className="OK" onClick={()=>setShowModal(false)}>확인</button>
        </div>
      </div>
    )}
  </>)
}
