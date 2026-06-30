/**
 * Calendar.jsx
 * IndexPage에서 분리된 FullCalendar + 좌측 필터 사이드바
 */
import { forwardRef, useEffect, useImperativeHandle, useRef } from 'react'

// FullCalendar 문자열을 <input type="datetime-local">가 받는 "YYYY-MM-DDTHH:mm" 형식으로 정규화
function toDatetimeLocal(s, defaultTime) {
  if (!s) return ''
  if (!s.includes('T')) return defaultTime ? `${s}T${defaultTime}` : s
  return s.slice(0, 16)
}

const Calendar = forwardRef(function Calendar(
  { workOrders, users, robots, onSelect, onEventClick, onEventSaveMoveResize },
  ref
) {
  const calRef  = useRef(null)
  const calInst = useRef(null)

  useImperativeHandle(ref, () => ({
    today: () => calInst.current?.today(),
    refetchEvents: () => calInst.current?.refetchEvents(),
  }))

  // FullCalendar 초기화
  useEffect(() => {
    if (!calRef.current || !window.FullCalendar) return
    const FC = window.FullCalendar

    const cal = new FC.Calendar(calRef.current, {
      height: '100%',
      expandRows: true,
      locale: 'ko',
      initialView: 'dayGridMonth',
      headerToolbar: {
        left: 'prev,next',
        center: 'title',
        right: 'dayGridMonth,listWeek,timeGridDay'
      },
      buttonText: { month: '월간', week: '주', day: '일일', today: '오늘', list: '주간' },
      navLinks: true,
      nowIndicator: true,
      selectable: true,
      editable: true,
      events: {
        url: '/api/events',
        method: 'GET',
        extraParams: () => ({ _t: Date.now() }),
        failure: () => console.error('일정 로드 실패')
      },
      // 날짜 드래그 선택 → 새 일정 모달 (CalendarModal.jsp select 동작)
      select: (sel) => {
        const start = toDatetimeLocal(sel.startStr, '09:00')
        const startDate = start.slice(0, 10)
        let endDate = sel.endStr ? sel.endStr.slice(0, 10) : startDate
        // FullCalendar의 allDay 선택 종료일은 배타적(다음날)이므로, 하루 빼서 포함 종료일로 보정
        // (toISOString은 UTC로 변환되어 한국 시간대에서 하루가 더 밀리므로 로컬 날짜 연산으로 처리)
        if (sel.allDay && endDate !== startDate) {
          const [y, m, d] = endDate.split('-').map(Number)
          const dt = new Date(y, m - 1, d)
          dt.setDate(dt.getDate() - 1)
          const pad = v => String(v).padStart(2, '0')
          endDate = `${dt.getFullYear()}-${pad(dt.getMonth() + 1)}-${pad(dt.getDate())}`
        }
        const end = `${endDate}T18:00`
        onSelect({ start, end, allDay: sel.allDay })
      },
      // 이벤트 클릭 → 수정 모달
      eventClick: (info) => {
        const e = info.event
        const start = toDatetimeLocal(e.startStr, '09:00')
        const end = toDatetimeLocal(e.endStr, '18:00') || `${start.slice(0, 10)}T18:00`
        onEventClick({
          id:       e.id,
          type:     e.extendedProps.type     || 'HUMAN',
          category: e.extendedProps.category || '업무',
          memo:     e.extendedProps.memo     || '',
          title:    e.title,
          start,
          end,
          allDay:   e.allDay,
        })
      },
      eventDrop:   (info) => onEventSaveMoveResize(info),
      eventResize: (info) => onEventSaveMoveResize(info),
      views: { dayGridMonth: { displayEventTime: false } },
      datesSet: () => {
        // 평일/주말 헤더 색상 (script.js topdesign() 대체)
        for (let i = 0; i < 7; i++) {
          const th = document.querySelectorAll('.fc-col-header th.fc-day')[i]
          if (!th) continue
          th.style.backgroundColor = (i === 0 || i === 6) ? 'red' : 'blue'
          th.style.color = 'white'
        }
      }
    })
    cal.render()
    calInst.current = cal
    return () => cal.destroy()
  }, [])

  return (
    <div className="CalendarDiv">
      {/* ── 좌측 필터 사이드바 ── */}
      <aside className="side">
        <div>
          <h3>표기 대상</h3>
          <label className="cat flex">
            <input type="checkbox" className="workorder" defaultChecked /> <span style={{whiteSpace:'nowrap'}}>오더</span>
            <input type="text" list="getWorkOrder" placeholder="워크오더 검색" style={{width:0,flex:1,minWidth:60}} />
            <datalist id="getWorkOrder">
              {workOrders.map(wo => <option key={wo.orderNum} value={wo.orderNum} />)}
            </datalist>
          </label>
          <label className="cat flex">
            <input type="checkbox" className="typeChk" value="HUMAN" defaultChecked
              onChange={() => calInst.current?.refetchEvents()} /> 휴먼
            <select>
              <option>ALL</option>
              {users.map(u => <option key={u.employeeNumber}>{u.userName}</option>)}
            </select>
          </label>
          <label className="cat flex">
            <input type="checkbox" className="typeChk" value="ROBOT" defaultChecked
              onChange={() => calInst.current?.refetchEvents()} /> 로봇
            <select>
              <option>ALL</option>
              {robots.map(r => <option key={r.robotNo}>{r.robotNo}</option>)}
            </select>
          </label>
        </div>
        <hr style={{ borderColor: '#263241', margin: '12px 0' }} />
        <div>
          <h3>업무 구분</h3>
          <label className="cat"><input type="radio" name="catChk" className="catChk" value="업무" defaultChecked /> 생산</label>
          <label className="cat"><input type="radio" name="catChk" className="catChk" value="개인" /> 기타</label>
        </div>
        <hr style={{ borderColor: '#263241', margin: '12px 0' }} />
        <div className="flex">
          <button onClick={() => calInst.current?.today()}>오늘</button>
          <button onClick={() => onSelect(null)}>일정 추가</button>
        </div>
      </aside>

      {/* ── 캘린더 ── */}
      <main ref={calRef} id="calendar" />
    </div>
  )
})

export default Calendar
