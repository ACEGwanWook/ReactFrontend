/**
 * IndexPage.jsx
 * mainpage.jsp + CalendarModal.jsp + script.js 통합
 * CalendarModal.jsp 구조 그대로 재현
 */
import { useEffect, useRef, useState } from 'react'
import { fetchEvents, createEvent, updateEvent, deleteEvent, fetchWorkOrders, fetchUsers, fetchRobots } from '../api'
import Calendar from '../components/Calendar'

const EMPTY_FORM = {
  id: null,
  type: 'HUMAN',
  category: '업무',
  memo: '',
  title: '',
  start: '',
  end: '',
  allDay: false,
}

export default function IndexPage() {
  const calRef      = useRef(null)
  const [workOrders, setWorkOrders] = useState([])
  const [users,      setUsers]      = useState([])
  const [robots,     setRobots]     = useState([])
  const [showModal,  setShowModal]  = useState(false)
  const [form,       setForm]       = useState(EMPTY_FORM)
  const isEdit = !!form.id

  useEffect(() => {
    Promise.all([fetchWorkOrders(), fetchUsers(), fetchRobots()])
      .then(([wo, us, ro]) => { setWorkOrders(wo); setUsers(us); setRobots(ro) })
      .catch(console.error)
  }, [])

  // 날짜 드래그 선택 → 새 일정 모달 (CalendarModal.jsp select 동작), 사이드바 "일정 추가" 클릭 시 sel === null
  function handleSelect(sel) {
    setForm(sel ? { ...EMPTY_FORM, ...sel } : EMPTY_FORM)
    setShowModal(true)
  }

  // 이벤트 클릭 → 수정 모달
  function handleEventClick(eventForm) {
    setForm(eventForm)
    setShowModal(true)
  }

  async function saveMoveResize(info) {
    const e = info.event
    try {
      await updateEvent(e.id, {
        title: e.title, allDay: e.allDay,
        start: e.startStr, end: e.endStr,
        type: e.extendedProps.type,
        category: e.extendedProps.category ?? null,
        memo: e.extendedProps.memo ?? ''
      })
    } catch {
      info.revert(); alert('수정 실패')
    }
  }

  function closeModal() {
    setShowModal(false)
    setForm(EMPTY_FORM)
  }

  async function handleSubmit() {
    if (!form.title) return alert('제목을 입력하세요.')
    try {
      if (isEdit) await updateEvent(form.id, form)
      else        await createEvent(form)
      calRef.current?.refetchEvents()
      closeModal()
    } catch (e) { alert('저장 실패: ' + e.message) }
  }

  async function handleDelete() {
    try {
      await deleteEvent(form.id)
      calRef.current?.refetchEvents()
      closeModal()
    } catch (e) { alert('삭제 실패: ' + e.message) }
  }

  function set(field) {
    return e => setForm(p => ({ ...p, [field]: e.target.type === 'checkbox' ? e.target.checked : e.target.value }))
  }

  return (
    <>
      <Calendar
        ref={calRef}
        workOrders={workOrders}
        users={users}
        robots={robots}
        onSelect={handleSelect}
        onEventClick={handleEventClick}
        onEventSaveMoveResize={saveMoveResize}
      />

      {/* ══ CalendarModal.jsp 그대로 재현 ══════════════════════ */}
      {showModal && (
        <div
          className="Modal"
          style={{ display: 'flex', alignItems: 'center', justifyContent: 'center',
            position: 'fixed', inset: 0, zIndex: 2000,
            background: 'rgba(0,0,0,0.45)' }}
          onClick={e => { if (e.target === e.currentTarget) closeModal() }}
        >
          <div className="CalendarModal flex-column" style={{ minWidth: 420, maxWidth: 540, width: '90%' }}>

            {/* header — "일정 추가" + X 버튼 */}
            <header className="justifybetween" style={{ display: 'flex', alignItems: 'center', marginBottom: 8 }}>
              <span className="setEvent">{isEdit ? '일정 수정' : '일정 추가'}</span>
              <button type="button" className="closeModal" onClick={closeModal}>X</button>
            </header>

            {/* HUMAN / 로봇 라디오 */}
            <label>
              <input type="radio" name="type" value="HUMAN"
                checked={form.type === 'HUMAN'} onChange={set('type')} /> HUMAN
            </label>
            <label>
              <input type="radio" name="type" value="ROBOT"
                checked={form.type === 'ROBOT'} onChange={set('type')} /> 로봇
            </label>

            {/* 일정 종류 */}
            <div className="flex" id="humanCats" style={{ alignItems: 'center', gap: 12, margin: '6px 0' }}>
              <h3 style={{ margin: 0 }}>일정 종류</h3>
              <label className="cat">
                <input type="radio" className="setChk" name="category" value="업무"
                  checked={form.category === '업무'} onChange={set('category')} /> 생산
              </label>
              <label className="cat">
                <input type="radio" className="setChk" name="category" value="개인"
                  checked={form.category === '개인'} onChange={set('category')} /> 기타
              </label>
            </div>

            {/* 일정 내용 textarea */}
            <span>일정 내용</span>
            <textarea
              className="detail"
              cols={70} rows={10}
              name="memo"
              value={form.memo}
              onChange={set('memo')}
            />

            {/* 제목 */}
            <label style={{ marginTop: 8 }}>
              제목 : <input type="text" id="title" name="title" className="width75"
                value={form.title} onChange={set('title')} required />
            </label>

            {/* 시작 / 종료 */}
            <div className="flex QualityReactive" style={{ gap: 12, marginTop: 6 }}>
              <label>
                시작 : <input type="datetime-local" className="setStart" name="start"
                  value={form.start} onChange={set('start')} required />
              </label>
              <label>
                종료 : <input type="datetime-local" className="setEnd" name="end"
                  value={form.end} onChange={set('end')} required />
              </label>
            </div>

            {/* 당일 체크박스 */}
            <label style={{ marginTop: 6 }}>
              <input type="checkbox" id="allDay" name="allDay"
                checked={form.allDay} onChange={set('allDay')} /> 당일
            </label>

            {/* 버튼 — 원본: 확인(submit) / 수정 / 삭제(edit일 때) / 취소 */}
            <div style={{ marginTop: 10, display: 'flex', gap: 8 }}>
              <input type="submit" value={isEdit ? '수정' : '확인'} className="SubmitOK"
                onClick={handleSubmit} style={{ cursor: 'pointer' }} />
              {isEdit && (
                <button type="button" id="btnDelete" onClick={handleDelete}>삭제</button>
              )}
              <button type="button" className="EventCancel" onClick={closeModal}>취소</button>
            </div>
          </div>
        </div>
      )}
    </>
  )
}
