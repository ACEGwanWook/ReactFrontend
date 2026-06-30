/**
 * IrRegularDataPage.jsx
 * IrRegularData.jsp + weldingerror.jsp 완전 재현
 * - 검색 필터: 작업일자 / 작업호선 / 장비번호 / Case / 조치유무
 * - 이미지 버튼 그리드 (gridbuttondiv)
 * - 클릭 시 weldingerror.jsp 상세 모달
 */
import { useEffect, useState } from 'react'
import PageHeader from '../components/PageHeader'

const BASE = ''
async function get(path, params = {}) {
  const qs = new URLSearchParams(params).toString()
  const res = await fetch(`${BASE}${path}${qs ? '?' + qs : ''}`)
  if (!res.ok) throw new Error(`API 오류: ${res.status}`)
  return res.json()
}

export default function IrRegularDataPage() {
  const [data,      setData]      = useState([])
  const [errInfos,  setErrInfos]  = useState([])
  const [actions,   setActions]   = useState([])
  const [selected,  setSelected]  = useState(null)
  const [showModal, setShowModal] = useState(false)

  // 검색 폼
  const [search, setSearch] = useState({
    errDate: '', projNo: '', robotNo: '', errInfo: '전체', action: '전체'
  })

  useEffect(() => {
    get('/api/irregular-data').then(setData).catch(console.error)
    get('/api/irregular-data/err-info').then(setErrInfos).catch(console.error)
    get('/api/irregular-data/actions').then(setActions).catch(console.error)
  }, [])

  function handleSearch() {
    get('/api/irregular-data', search).then(setData).catch(console.error)
  }

  function handleSave() {
    if (!selected) return alert('저장할 항목을 선택하세요.')
    fetch('/api/irregular-data', {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(selected)
    }).then(r => r.text()).then(msg => { alert(msg); setShowModal(false) })
      .catch(e => alert(e.message))
  }

  function sf(field) {
    return e => setSearch(p => ({ ...p, [field]: e.target.value }))
  }
  function mf(field) {
    return e => setSelected(p => ({ ...p, [field]: e.target.value }))
  }

  return (
    <>
      <PageHeader title="용접불량조지결과 관리">
        <input type="checkbox" value="소조" /> 소조
        <input type="checkbox" value="중조" defaultChecked /> 중조
        <button onClick={handleSearch}>검색</button>
        <button onClick={handleSave}>저장</button>
        <button onClick={() => { setSelected(null); setShowModal(false) }}>취소</button>
      </PageHeader>

      {/* 검색 필터 */}
      <div className="flex irregular">
        <input type="hidden" className="ErrNum" value={selected?.errNum || ''} />
        <label className="width20 flex">
          <span>작업일자 </span>
          <input type="text" className="formtext setErrDate"
            value={search.errDate} onChange={sf('errDate')} />
        </label>
        <label className="width20 flex">
          <span>작업호선 </span>
          <input type="text" className="formtext setProjNo"
            value={search.projNo} onChange={sf('projNo')} />
        </label>
        <label className="width20 flex">
          <span>장비번호 </span>
          <input type="text" className="formtext setRobotNo"
            value={search.robotNo} onChange={sf('robotNo')} />
        </label>
        <label className="width20 flex">
          <span>Case </span>
          <select className="formtext setErrInfo"
            value={search.errInfo} onChange={sf('errInfo')}>
            <option>전체</option>
            {errInfos.map((e, i) => <option key={i}>{e.errInfo}</option>)}
          </select>
        </label>
        <label className="width20 flex">
          <span>조치유무 </span>
          <select className="formtext setAction"
            value={search.action} onChange={sf('action')}>
            <option>전체</option>
            {actions.map((a, i) => <option key={i}>{a.action}</option>)}
          </select>
        </label>
      </div>

      {/* 이미지 버튼 그리드 */}
      <div className="gridbuttondiv">
        {data.map((d, i) => (
          <button
            key={i}
            className="databutton relative"
            onClick={() => { setSelected({ ...d }); setShowModal(true) }}
          >
            <img src="/images/weldingerror.png" alt="용접오류" />
            <br />
            <input type="hidden" className="RobotNo"    value={d.robotNo    || ''} />
            <input type="hidden" className="BlockName"  value={d.blockName  || ''} />
            {d.projNo}-{d.blockName}-{d.assy}-{d.cellNum}
          </button>
        ))}
      </div>

      {/* weldingerror.jsp 상세 모달 */}
      {showModal && selected && (
        <div style={{
          display: 'flex', alignItems: 'center', justifyContent: 'center',
          position: 'fixed', inset: 0, zIndex: 2000, background: 'rgba(0,0,0,0.5)'
        }}
          onClick={e => { if (e.target === e.currentTarget) setShowModal(false) }}>
          <div className="weldingerrordetail">

            {/* 모달 헤더 */}
            <div className="topmenu justifybetween" style={{ display: 'flex', alignItems: 'center' }}>
              <span>
                <img src="/Images/모달헤더.png" alt="" onError={e => e.target.style.display = 'none'} />
                용접불량 상세정보
              </span>
            </div>

            {/* 폼 행 1 */}
            <div className="flex formstyle">
              <label className="width25 flex">
                <span>작업일자 </span>
                <input type="text" className="formtext textcenter detailinput getDate"
                  value={selected.errDate || ''} onChange={mf('errDate')} />
              </label>
              <label className="width25 flex">
                <span>호선번호 </span>
                <input type="text" className="formtext textcenter detailinput getProj"
                  value={selected.projNo || ''} onChange={mf('projNo')} />
              </label>
              <label className="width25 flex">
                <span>블록번호 </span>
                <input type="text" className="formtext textcenter detailinput getBlock"
                  value={selected.blockName || ''} readOnly />
              </label>
            </div>

            {/* 폼 행 2 */}
            <div className="flex formstyle">
              <label className="width25 flex">
                <span>장비명 </span>
                <input type="text" className="formtext textcenter detailinput getRobot"
                  value={selected.robotNo || ''} onChange={mf('robotNo')} />
              </label>
              <label className="width25 flex">
                <span>불량정보 </span>
                <input type="text" className="formtext textcenter detailinput getErr"
                  value={selected.errInfo || ''} onChange={mf('errInfo')} />
              </label>
              <label className="width50 flex">
                <span>위치정보 </span>
                <input type="text" className="formtext textcenter width25 getmm detailinput"
                  value={selected.locationMM || ''} readOnly />
                <input type="text" className="formtext textcenter width25 detailinput getX"
                  value={selected.locationX || ''} readOnly />
                <input type="text" className="formtext textcenter width25 detailinput getY"
                  value={selected.locationY || ''} readOnly />
              </label>
            </div>

            {/* 이미지 */}
            <div className="bgwhite aligncenter relative">
              <img src="/images/weldingerror.png" alt="용접오류" />
            </div>

            <button className="OK" onClick={handleSave}>확인</button>
            <button className="closeDetailModal" onClick={() => setShowModal(false)}>x</button>
          </div>
        </div>
      )}
    </>
  )
}
