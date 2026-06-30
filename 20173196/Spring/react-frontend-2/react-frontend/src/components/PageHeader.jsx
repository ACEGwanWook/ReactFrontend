/**
 * PageHeader.jsx
 * 모든 페이지 상단의 제목 + 버튼 영역 공통 컴포넌트
 * JSP의 <div class="showmainheader"> 를 대체
 */
export default function PageHeader({ title, icon, children }) {
  return (
    <div className="showmainheader flex justifybetween aligncenter">
      <span className="flex aligncenter">
        {icon && <span className={icon} style={{ width: 28, height: 28, marginRight: 6 }} />}
        {title}
      </span>
      <div className="buttondiv flex aligncenter" style={{ gap: 4 }}>
        {children}
      </div>
    </div>
  )
}
