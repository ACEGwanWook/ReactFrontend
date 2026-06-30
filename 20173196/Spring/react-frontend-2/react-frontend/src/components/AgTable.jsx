/**
 * AgTable.jsx
 * 전체 페이지 공통 AG Grid 래퍼 컴포넌트
 *
 * props:
 *   columnDefs   - AG Grid 컬럼 정의 배열
 *   rowData      - 데이터 배열
 *   onRowClicked - 행 클릭 콜백 (e.data 로 행 데이터 접근)
 *   height       - 테이블 높이 (기본 'calc(100vh - 280px)')
 *   pagination   - 페이지네이션 여부 (기본 true)
 *   pageSize     - 페이지당 행 수 (기본 20)
 *   selected     - 선택된 행 식별 함수 (row => bool)
 */
import { useCallback, useMemo } from 'react'
import { AgGridReact } from 'ag-grid-react'

import 'ag-grid-community/styles/ag-grid.css'
import 'ag-grid-community/styles/ag-theme-alpine.css'

/* 기존 CSS 변수와 맞춘 AG Grid 다크 테마 오버라이드 */
const THEME_STYLE = `
  .ag-theme-alpine-dark {
    --ag-background-color:          #0d1b2a;
    --ag-odd-row-background-color:  #0a1628;
    --ag-header-background-color:   #1a3a5c;
    --ag-header-foreground-color:   #e6edf3;
    --ag-foreground-color:          #c9d1d9;
    --ag-row-hover-color:           rgba(78,157,224,0.12);
    --ag-selected-row-background-color: rgba(78,157,224,0.25);
    --ag-border-color:              rgba(255,255,255,0.08);
    --ag-cell-horizontal-border:    solid rgba(255,255,255,0.06);
    --ag-font-size:                 13px;
    --ag-row-height:                36px;
    --ag-header-height:             40px;
    --ag-pagination-panel-color:    #8b949e;
    --ag-input-focus-border-color:  #4e9de0;
  }
  .ag-theme-alpine-dark .ag-header-cell-label {
    justify-content: center;
  }
  .ag-theme-alpine-dark .ag-cell {
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .ag-theme-alpine-dark .ag-paging-panel {
    color: #8b949e;
    border-top: 1px solid rgba(255,255,255,0.08);
  }
`

export default function AgTable({
  columnDefs,
  rowData,
  onRowClicked,
  height = 'calc(100vh - 280px)',
  pagination = true,
  pageSize = 20,
}) {
  const defaultColDef = useMemo(() => ({
    sortable:   true,
    filter:     true,
    resizable:  true,
    flex:       1,
    minWidth:   80,
    cellStyle:  { textAlign: 'center' },
    headerClass: 'ag-center-header',
  }), [])

  const getRowClass = useCallback(params => {
    return params.node.rowIndex % 2 === 0 ? 'ag-row-even' : 'ag-row-odd'
  }, [])

  return (
    <>
      <style>{THEME_STYLE}</style>
      <div
        className="ag-theme-alpine-dark"
        style={{ width: '100%', height }}
      >
        <AgGridReact
          columnDefs={columnDefs}
          rowData={rowData ?? []}
          defaultColDef={defaultColDef}
          onRowClicked={onRowClicked}
          getRowClass={getRowClass}
          pagination={pagination}
          paginationPageSize={pageSize}
          rowHeight={36}
          headerHeight={40}
          suppressMovableColumns={false}
          animateRows={true}
          overlayNoRowsTemplate="<span style='color:#8b949e'>데이터가 없습니다</span>"
          overlayLoadingTemplate="<span style='color:#4e9de0'>로딩 중...</span>"
          localeText={{
            page:             '페이지',
            more:             '더보기',
            to:               '~',
            of:               '/',
            next:             '다음',
            last:             '마지막',
            first:            '처음',
            previous:         '이전',
            loadingOoo:       '로딩 중...',
            noRowsToShow:     '데이터가 없습니다',
            filterOoo:        '필터...',
            applyFilter:      '적용',
            resetFilter:      '초기화',
            clearFilter:      '지우기',
            selectAll:        '전체 선택',
            searchOoo:        '검색...',
            blanks:           '비어있음',
            equals:           '같음',
            notEqual:         '다름',
            lessThan:         '미만',
            greaterThan:      '초과',
            contains:         '포함',
            notContains:      '미포함',
            startsWith:       '시작',
            endsWith:         '끝',
          }}
        />
      </div>
    </>
  )
}
