import { useEffect, useState } from 'react'
import PageHeader from '../components/PageHeader'
import DataTable from '../components/DataTable'
import { fetchQualityModel } from '../api'

const COLS = [
  { headerName:'No',       valueGetter:'node.rowIndex+1', width:55 },
  { headerName:'호선명',   field:'projNo',         flex:1 },
  { headerName:'블록명',   field:'blockName',      flex:1 },
  { headerName:'ASSY',     field:'assyName',       flex:1 },
  { headerName:'Cell',     field:'cellNo',         width:70 },
  { headerName:'표준타입', field:'cellType',       flex:1 },
  { headerName:'로봇번호', field:'robotNo',        flex:1 },
  { headerName:'Bay',      valueGetter:()=>'4번 Bay', width:80 },
  { headerName:'품질상태', field:'qualityTagInfo', flex:1,
    cellStyle:p=>({ color: p.value==='정상'?'#3fb950':p.value==='불량'?'#f85149':'inherit', fontWeight:'bold' }) },
  { headerName:'시간',     field:'pictFileDateTime', flex:2 },
  { headerName:'작업자',   valueGetter:()=>'손관욱', flex:1 },
  { headerName:'최종판단', field:'tagUser',        flex:1 },
  { headerName:'Comment',  field:'qualityErrorDesc', flex:2 },
]

export default function QualityModelPage() {
  const [data,setData]=useState([])
  const [selected,setSelected]=useState(null)
  useEffect(()=>{ fetchQualityModel().then(rows=>{ setData(rows); if(rows.length>0)setSelected(rows[0]) }).catch(console.error) },[])
  const sel=selected||{}

  return(<>
    <PageHeader title="AI 용접 품질 결과 데이터 관리">
      <input type="checkbox" value="소조" />소조
      <input type="checkbox" value="중조" defaultChecked />중조
    </PageHeader>
    <div className="flex QualityReactive">
      <div className="flex-column imginfo"><span>용접 전 이미지</span><img className="weldimg" src="/images/cell7normal.png" alt="용접 전" /></div>
      <div className="flex-column imginfo"><span>용접 후 이미지</span><img className="weldimg" src="/images/cell7.png" alt="용접 후" /></div>
      <div className="flex-column width100">
        <div className="flex">
          <div className="width25 flex-column datainfo" style={{backgroundColor:'red'}}><span>호선명</span><span className="value">{sel.projNo||'-'}</span></div>
          <div className="width25 flex-column datainfo" style={{backgroundColor:'orangered'}}><span>블록명</span><span className="value">{sel.blockName||'-'}</span></div>
          <div className="width25 flex-column datainfo" style={{backgroundColor:'orange'}}><span>ASSY</span><span className="value">{sel.assyName||'-'}</span></div>
          <div className="width25 flex-column datainfo" style={{backgroundColor:sel.qualityTagInfo==='정상'?'green':'red'}}><span>품질상태</span><span className="value">{sel.qualityTagInfo||'-'}</span></div>
        </div>
        <div className="flex">
          <div className="width25 flex-column datainfo" style={{backgroundColor:'red'}}><span>표준타입</span><span className="value">{sel.cellType||'-'}</span></div>
          <div className="width25 flex-column datainfo" style={{backgroundColor:'orangered'}}><span>로봇번호</span><span className="value">{sel.robotNo||'-'}</span></div>
          <div className="width25 flex-column datainfo" style={{backgroundColor:'orange'}}><span>Bay</span><span className="value">4번 Bay</span></div>
          <div className="width25 flex-column datainfo" style={{backgroundColor:'red'}}><span>최종판단</span><span className="value">{sel.tagUser||'-'}</span></div>
        </div>
        <div className="flex">
          <div className="width50 flex-column datainfo" style={{backgroundColor:'red'}}><span>시간</span><span className="value">{sel.pictFileDateTime||'-'}</span></div>
          <div className="width50 flex-column datainfo" style={{backgroundColor:'red'}}><span>Comment</span><span className="value">{sel.qualityErrorDesc||'-'}</span></div>
        </div>
      </div>
    </div>
    <DataTable rowData={data} columnDefs={COLS} onRowClicked={setSelected} height={320} />
  </>)
}
