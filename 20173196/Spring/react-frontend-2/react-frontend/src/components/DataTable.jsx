/**
 * DataTable.jsx
 * AG-Grid 공통 래퍼 컴포넌트
 * 기존 <table className="RobotTable"> 를 전부 이걸로 교체
 *
 * Props:
 *   rowData      - 데이터 배열
 *   columnDefs   - AG-Grid 컬럼 정의
 *   onRowClicked - 행 클릭 콜백 (data 객체 전달)
 *   height       - 테이블 높이 (기본 560px)
 *   pageSize     - 페이지당 행 수 (기본 20)
 *   noRowsText   - 데이터 없을 때 메시지
 */
import { AgGridReact } from 'ag-grid-react'
import { useMemo } from 'react'

// AG-Grid 필수 CSS
import 'ag-grid-community/styles/ag-grid.css'
import 'ag-grid-community/styles/ag-theme-alpine.css'

const DEFAULT_COL = {
  sortable:   true,
  filter:     true,
  resizable:  true,
  minWidth:   70,
  cellStyle:  { display: 'flex', alignItems: 'center' },
}

export default function DataTable({
  rowData       = [],
  columnDefs    = [],
  onRowClicked,
  height        = 560,
  pageSize      = 20,
  noRowsText    = '데이터가 없습니다.',
}) {
  const localeText = useMemo(() => ({
    noRowsToShow:    noRowsText,
    page:            '페이지',
    more:            '더보기',
    to:              '~',
    of:              '/',
    next:            '다음',
    last:            '마지막',
    first:           '처음',
    previous:        '이전',
    loadingOoo:      '로딩 중...',
    filterOoo:       '필터...',
    applyFilter:     '적용',
    equals:          '같음',
    notEqual:        '다름',
    lessThan:        '미만',
    greaterThan:     '초과',
    contains:        '포함',
    notContains:     '미포함',
    startsWith:      '시작',
    endsWith:        '끝',
    blank:           '공백',
    notBlank:        '비공백',
    andCondition:    'AND',
    orCondition:     'OR',
  }), [noRowsText])

  return (
    <div
      className="ag-theme-alpine-dark"
      style={{ width: '100%', height }}
    >
      <AgGridReact
        rowData={rowData}
        columnDefs={columnDefs}
        defaultColDef={DEFAULT_COL}
        onRowClicked={e => onRowClicked?.(e.data)}
        pagination={true}
        paginationPageSize={pageSize}
        rowSelection="single"
        suppressCellFocus={true}
        animateRows={true}
        localeText={localeText}
        rowHeight={36}
        headerHeight={38}
        /* 선택 행 강조 */
        getRowStyle={params =>
          params.node.isSelected()
            ? { background: 'rgba(30,144,255,0.2)', color: '#4e9de0' }
            : undefined
        }
      />
    </div>
  )
}
