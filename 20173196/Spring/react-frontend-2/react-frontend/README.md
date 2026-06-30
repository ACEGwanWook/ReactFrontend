# 용접 로봇 AI 운영 시스템 — React 전환 완성본

## 📁 폴더 구조

```
react-frontend/
├── src/
│   ├── main.jsx                 ← 앱 진입점
│   ├── App.jsx                  ← page.jsp + 탭 시스템 (tabs.js 대체)
│   ├── index.css                ← 기존 CSS import
│   ├── api/
│   │   └── index.js             ← 모든 fetch 호출 (Model.addAttribute 대체)
│   ├── components/
│   │   ├── Sidebar.jsx          ← Sidebar.jsp + sidebar.js 대체
│   │   └── PageHeader.jsx       ← showmainheader 공통 컴포넌트
│   └── pages/
│       ├── IndexPage.jsx        ← mainpage.jsp + CalendarModal.jsp + script.js
│       ├── CommonCodePage.jsx   ← CommonCode.jsp + CommonCode.js
│       ├── RobotResourcePage.jsx← RobotResource.jsp + RobotResource.js
│       ├── AutoAssetPage.jsx    ← AutoAsset.jsp + AutoAssetAction.js
│       ├── MaintenancePage.jsx  ← Maintenance.jsp + errordiv.jsp + receivediv.jsp
│       ├── DesignInfoPage.jsx   ← DesignInfo.jsp + Designinfo.js
│       ├── IOTDataPage.jsx      ← IOTData.jsp + IOTData.js (3탭 + 차트)
│       ├── QualityModelPage.jsx ← QualityModel.jsp
│       ├── SituationDataModelPage.jsx
│       ├── IrRegularDataPage.jsx← IrRegularData.jsp + weldingerror.jsp(모달)
│       ├── WeldDatasetPage.jsx  ← WeldDataset.jsp
│       ├── AutoSitutationPage.jsx ← AutoSitutation.jsp + Chart.js
│       ├── ProductSituationPage.jsx
│       ├── RobotLinePage.jsx    ← ECharts 사용
│       ├── BlockMoniteringPage.jsx
│       ├── WorkOrderPage.jsx    ← WorkOrder.jsp + WorkOrder.js
│       ├── RobotOrderPage.jsx
│       └── DispatchWipPage.jsx
│
└── backend-rest-controllers/
    └── MainRestController.java  ← MainController.java를 @RestController로 전환
```

---

## 🚀 실행 방법

### 1. 프론트엔드 (React)

```bash
cd react-frontend
npm install
npm run dev        # http://localhost:5173
```

### 2. 백엔드 (Spring Boot)

- `MainRestController.java`를 기존 프로젝트의 `com.example.uiproject` 패키지에 추가
- 기존 `MainController.java` 삭제 또는 `@Controller → @RestController`로 변경
- 불필요한 클래스 삭제: `PageFactory.java`, `PageConfig.java`, `PageService.java`
- Spring Boot 실행: `./gradlew bootRun` (포트 8080)

> Vite가 `/api/*` 요청을 `http://localhost:8080`으로 프록시합니다. (`vite.config.js` 참조)

---

## 📋 기존 파일 대응표

| 기존 (JSP) | 변환 후 (React) | 변경 내용 |
|---|---|---|
| `Sidebar.jsp` + `sidebar.js` | `Sidebar.jsx` | `<a href>` → `<NavLink to>` |
| `page.jsp` (레이아웃) | `App.jsx` | `<Outlet>` + React Router |
| `PageFactory.java` | `routes.jsx` (App.jsx 내 Routes) | switch/case → Route 선언 |
| `Model.addAttribute(...)` | `fetch('/api/...')` | 서버사이드 → REST API |
| `<c:forEach>` | `.map(item => <tr>...)` | JSTL → JSX |
| `<c:if test="...">` | `{condition && <div>}` | JSTL → 삼항 연산자 |
| `${ el.variable }` | `{data.variable}` | EL → JSX 표현식 |
| `script.js` (시계, 탭) | `App.jsx` `useEffect` | jQuery → React 훅 |
| `tabs.js` | `useTabHistory()` 훅 | 전역 DOM → 상태 관리 |

---

## ⚠️ CSS 처리

`style.css`, `reactive.css`, `sidebar.css`는 **그대로 사용**합니다.

**개발 환경**: Spring Boot `static/css/` 폴더의 파일을
React 프로젝트의 `public/css/`에 복사하거나 심볼릭 링크를 걸어주세요.

```bash
# 예시 (프로젝트 루트에서)
cp -r uiproject/src/main/resources/static/css  react-frontend/public/css
cp -r uiproject/src/main/resources/static/images react-frontend/public/images
cp -r uiproject/src/main/resources/static/script react-frontend/public/script
```

**배포 환경**: Vite `build` 후 `dist/` 폴더를 Spring Boot `static/` 안에 넣으면
Spring Boot 하나로 프론트+백엔드를 같이 서빙할 수 있습니다.

---

## 🔧 백엔드 추가 작업 목록

`MainRestController.java`에서 주석 처리된 메서드들을 실제 DAO 메서드명에 맞게 연결하세요:

- [ ] `roboterrDAO.insertRepair()` / `updateRepair()` / `deleteRepair()` 메서드 연결
- [ ] IOT 데이터: `weldingDAO.getJoinAll()` / `.getSummary()` / `.getRecords()` 메서드 확인
- [ ] ScheduleEventController.java의 `/api/events` REST API는 기존 파일 유지 (이미 REST)
- [ ] CORS 설정 (별도 서버 배포 시): `WebMvcConfigurer` 또는 `@CrossOrigin` 추가

---

## 📦 기존 Spring Boot에서 삭제 가능한 파일

- `MainController.java` → `MainRestController.java`로 대체
- `PageFactory.java` → 불필요 (React Router가 대체)
- `PageConfig.java`  → 불필요
- `PageService.java` → 불필요
- `BrotilHeaderFilter.java` → 필요 시 유지 (Brotli 압축)
- `src/main/resources/templates/` (JSP 파일들) → 불필요 (React가 대체)
