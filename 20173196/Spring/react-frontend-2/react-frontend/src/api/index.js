/**
 * api/index.js
 * JSP에서 Model.addAttribute()로 넘겨주던 데이터를
 * REST API fetch로 대체합니다.
 *
 * 백엔드: @RestController 로 전환된 Spring Boot
 */

// src/api/index.js 상단 부분 — 4개 함수 교체
const BASE = ''
 
// Content-Type에 따라 자동으로 JSON 또는 text로 파싱
async function parseResponse(res) {
  const ct = res.headers.get('content-type') || ''
  return ct.includes('application/json') ? res.json() : res.text()
}
 
async function get(path, params = {}) {
  const qs = new URLSearchParams(params).toString()
  const res = await fetch(`${BASE}${path}${qs ? '?' + qs : ''}`)
  if (!res.ok) throw new Error(`API 오류: ${res.status} ${path}`)
  return parseResponse(res)
}
 
async function post(path, body) {
  const res = await fetch(`${BASE}${path}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body),
  })
  if (!res.ok) throw new Error(await res.text())
  return parseResponse(res)
}
 
async function put(path, body) {
  const res = await fetch(`${BASE}${path}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body),
  })
  if (!res.ok) throw new Error(await res.text())
  return parseResponse(res)
}
 
async function del(path, params = {}) {
  const qs = new URLSearchParams(params).toString()
  const res = await fetch(`${BASE}${path}${qs ? '?' + qs : ''}`, { method: 'DELETE' })
  if (!res.ok) throw new Error(await res.text())
  return parseResponse(res)
}

// ─── 메인 페이지 ───────────────────────────────────────────
export const fetchMainPage    = () => get('/api/main')
export const fetchEvents      = (params) => get('/api/events', params)
export const createEvent      = (body)   => post('/api/events', body)
export const updateEvent      = (id, body) => put(`/api/events/${id}`, body)
export const deleteEvent      = (id)     => del(`/api/events/${id}`)

// ─── 기준정보관리 ────────────────────────────────────────────
export const fetchGroupCounts = ()        => get('/api/codes/groups')
export const fetchCodesByGroup= (group)   => get('/api/codes', { group })
export const insertCode       = (body)    => post('/api/codes', body)
export const updateCode       = (body)    => put('/api/codes', body)
export const deleteCode       = (code, groupCode) => del('/api/codes', { code, groupCode })

export const fetchUsers       = (params={}) => get('/api/users', params)
export const fetchGrades      = ()           => get('/api/users/grades')
export const insertUser       = (body)       => post('/api/users', body)
export const updateUser       = (body)       => put('/api/users', body)
export const deleteUser       = (employeeNumber) => del('/api/users', { employeeNumber })

// ─── 자동화 장비 자산 관리 ───────────────────────────────────
export const fetchRobots      = (params={}) => get('/api/robots', params)
export const insertRobot      = (body)      => post('/api/robots', body)
export const updateRobot      = (body)      => put('/api/robots', body)
export const deleteRobot      = (robotNo)   => del('/api/robots', { robotNo })

export const fetchRobotErrors = (params={}) => get('/api/robot-errors', params)
export const fetchRepairs     = (params={}) => get('/api/repairs', params)
export const fetchRobotNos    = ()           => get('/api/robots/nos')
export const fetchErrorReasons= ()           => get('/api/robot-errors/reasons')
export const fetchRepairParts = ()           => get('/api/repairs/parts')
export const insertRobotError = (body)       => post('/api/robot-errors', body)
export const updateRobotError = (body)       => put('/api/robot-errors', body)
export const deleteRobotError = (errNum)     => del('/api/robot-errors', { errNum })
export const insertRepair     = (body)       => post('/api/repairs', body)
export const updateRepair     = (body)       => put('/api/repairs', body)
export const deleteRepair     = (repairNo)   => del('/api/repairs', { repairNo })

// ─── 인공지능 데이터 관리 ────────────────────────────────────
export const fetchCellInfo    = (params={}) => get('/api/design-info', params)
export const insertCellInfo   = (body)      => post('/api/design-info', body)
export const updateCellInfo   = (body)      => put('/api/design-info', body)
export const deleteCellInfo   = (cellID)    => del('/api/design-info', { cellID })

export const fetchIotJoinAll  = (params={}) => get('/api/iot-data/files', params)
export const fetchIotSummary  = (params={}) => get('/api/iot-data/summary', params)
export const fetchIotRecords  = (params={}) => get('/api/iot-data/records', params)

export const fetchWeldDataset = (params={}) => get('/api/weld-dataset', params)
export const fetchIrRegular   = (params={}) => get('/api/irregular-data', params)
export const fetchIrRegularDetail = (id)    => get(`/api/irregular-data/${id}`)

export const fetchQualityModel = (params={}) => get('/api/quality-model', params)
export const fetchSituationModel = (params={}) => get('/api/situation-model', params)

// ─── 생산 상세 모니터링 ──────────────────────────────────────
export const fetchAutoSituation = (params={}) => get('/api/monitoring/auto-situation', params)
export const fetchProductSituation = (params={}) => get('/api/monitoring/product-situation', params)
export const fetchRobotLine   = (params={}) => get('/api/monitoring/robot-line', params)
export const fetchBlockMonitoring = (params={}) => get('/api/monitoring/block', params)

// ─── 통합 생산 관리 ─────────────────────────────────────────
export const fetchWorkOrders  = (params={}) => get('/api/work-orders', params)
export const fetchProjNos     = ()           => get('/api/work-orders/proj-nos')
export const insertWorkOrder  = (body)       => post('/api/work-orders', body)
export const updateWorkOrder  = (body)       => put('/api/work-orders', body)
export const deleteWorkOrder  = (orderNum)   => del('/api/work-orders', { orderNum })

export const fetchRobotOrders = (params={}) => get('/api/robot-orders', params)
export const fetchDispatchWip = (params={}) => get('/api/dispatch-wip', params)
