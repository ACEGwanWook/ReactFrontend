# 용접 로봇 AI 운영 시스템 — Spring Boot REST API 백엔드

JSP+MVC 방식을 제거하고 React 프론트엔드와 통신하는 순수 REST API 서버입니다.

---

## 📁 프로젝트 구조

```
src/main/java/com/example/uiproject/
├── UIprojectApplication.java       ← 앱 진입점
├── WebConfig.java                  ← CORS 설정 (React ↔ Spring 연결 핵심)
├── MainRestController.java         ← 메인 REST API (기존 MainController 대체)
├── ScheduleEventController.java    ← 캘린더 이벤트 API (기존 파일 그대로)
├── ScheduleEventRepository.java    ← JPA 레포지토리
├── InfluxProperties.java           ← InfluxDB 설정
├── InfluxService.java              ← InfluxDB 쿼리
└── Model/
    ├── CodeDAO.java                ← 공통코드 (원본 그대로)
    ├── UserDAO.java                ← 사용자 (원본 그대로)
    ├── RobotDAO.java               ← 로봇 자산 (원본 그대로)
    ├── RobotErrDAO.java            ← 고장/수선 (원본 그대로)
    ├── WorkOrderDAO.java           ← 워크오더 (원본 그대로)
    ├── CadCellDAO.java             ← 설계정보 (원본 그대로)
    ├── MainPageDAO.java            ← 메인페이지 (원본 그대로)
    ├── WeldingDAO.java             ← IOT 용접 데이터 (원본 그대로)
    ├── AbnPictDAO.java             ← 비정형 데이터 (원본 그대로)
    └── DTO 파일들 (전부 원본 그대로)
```

---

## 🚀 실행 방법

### 1. application.properties 수정

```properties
# DB 연결 정보를 실제 값으로 변경
spring.datasource.url=jdbc:mysql://localhost:3306/your_database?useSSL=false&serverTimezone=Asia/Seoul
spring.datasource.username=your_username
spring.datasource.password=your_password
```

### 2. 빌드 & 실행

```bash
./gradlew bootRun
# → http://localhost:8080 에서 실행됨
```

### 3. React 개발 서버와 연결

React 프론트엔드(`react-frontend`)의 `vite.config.js`에 이미 프록시가 설정되어 있습니다:
```
React (localhost:5173)  →  /api/*  →  Spring Boot (localhost:8080)
```

---

## 📋 API 엔드포인트 전체 목록

| Method | URL | 설명 |
|--------|-----|------|
| GET | `/api/main` | 메인페이지 초기 데이터 |
| GET | `/api/codes/groups` | 공통코드 그룹 목록 |
| GET | `/api/codes?group=그룹명` | 그룹별 코드 상세 |
| POST | `/api/codes` | 코드 등록 |
| PUT | `/api/codes` | 코드 수정 |
| DELETE | `/api/codes?code=코드` | 코드 삭제 |
| GET | `/api/users` | 사용자 목록 |
| GET | `/api/users/grades` | 직책 목록 |
| POST | `/api/users` | 사용자 등록 |
| PUT | `/api/users` | 사용자 수정 |
| DELETE | `/api/users?employeeNumber=사번` | 사용자 삭제 |
| GET | `/api/robots` | 로봇 목록 |
| GET | `/api/robots/nos` | 로봇 번호 목록 |
| POST | `/api/robots` | 로봇 등록 |
| PUT | `/api/robots` | 로봇 수정 |
| DELETE | `/api/robots?robotNo=번호` | 로봇 삭제 |
| GET | `/api/robot-errors` | 고장 이력 |
| GET | `/api/robot-errors/reasons` | 고장 사유 목록 |
| POST | `/api/robot-errors` | 고장 이력 등록 |
| PUT | `/api/robot-errors` | 고장 이력 수정 |
| DELETE | `/api/robot-errors?errNum=번호` | 고장 이력 삭제 |
| GET | `/api/repairs` | 수선 목록 |
| GET | `/api/repairs/parts` | 수선 부품 목록 |
| POST | `/api/repairs` | 수선 등록 |
| PUT | `/api/repairs` | 수선 수정 |
| DELETE | `/api/repairs?repairNo=번호` | 수선 삭제 |
| GET | `/api/design-info` | 설계정보 목록 |
| POST | `/api/design-info` | 설계정보 등록 |
| PUT | `/api/design-info` | 설계정보 수정 |
| DELETE | `/api/design-info?cellID=ID` | 설계정보 삭제 |
| GET | `/api/iot-data/files` | IOT 파일 목록 (탭1) |
| GET | `/api/iot-data/summary` | 용접 요약 (탭2 카드) |
| GET | `/api/iot-data/records` | 용접 상세 기록 (탭2/탭3) |
| GET | `/api/work-orders` | 워크오더 목록 |
| GET | `/api/work-orders/proj-nos` | 호선 번호 목록 |
| POST | `/api/work-orders` | 워크오더 등록 |
| PUT | `/api/work-orders` | 워크오더 수정 |
| DELETE | `/api/work-orders?orderNum=번호` | 워크오더 삭제 |
| GET/POST/PUT/DELETE | `/api/events/**` | 캘린더 이벤트 (기존 ScheduleEventController) |

---

## ⚠️ 기존 JSP 프로젝트와 차이점

| 항목 | 기존 (JSP) | 이 프로젝트 (REST) |
|------|-----------|------------------|
| 반환값 | JSP View | JSON |
| 어노테이션 | `@Controller` | `@RestController` |
| 삭제된 클래스 | — | `PageFactory`, `PageConfig`, `PageService`, `MainController`, `BrotilHeaderFilter` |
| 유지된 클래스 | — | 모든 DAO, DTO, ScheduleEventController |
