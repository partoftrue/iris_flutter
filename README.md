# 아이리스 (Iris)

아이리스는 일정 관리, 기록 관리, 근무 관리를 통합적으로 제공하는 모바일 애플리케이션입니다. 토스의 디자인 철학을 참고하여 직관적이고 사용하기 쉬운 UI/UX를 제공합니다.

## 주요 기능

### 1. 일정 관리
- 직관적인 캘린더 뷰
- 일정 추가/수정/삭제
- 일정 카테고리 분류
- 일정 알림 설정
- 드래그 앤 드롭으로 일정 이동
- 반복 일정 설정

### 2. 기록 관리
- 다양한 형태의 기록 작성 (텍스트, 이미지, 파일)
- 카테고리별 기록 분류
- 태그 기반 검색 기능
- 기록 미리보기
- 기록 공유 기능
- 기록 백업 및 복원

### 3. 근무 관리
- 사장님/알바생 구분
- 근무 일정 관리
- 출근 체크 (QR코드/위치 기반)
- 추가 근무 신청/승인
- 근무 시간 통계
- 급여 계산 기능
- 휴가/휴무 관리

## 기술 스택

### 프론트엔드
- Flutter (최신 버전)
- Provider (상태 관리)
- Table Calendar (캘린더 위젯)
- Shared Preferences (로컬 데이터 저장)
- Flutter Local Notifications (알림)
- GetIt (의존성 주입)
- Dio (HTTP 클라이언트)
- Flutter Secure Storage (보안 저장소)

### 백엔드
- NestJS
- PostgreSQL
- TypeORM
- JWT 인증
- Swagger (API 문서화)

## 설치 방법

1. Flutter 개발 환경 설정
```bash
# Flutter SDK 설치 확인
flutter doctor

# 의존성 설치
flutter pub get
```

2. 환경 변수 설정
```bash
# .env 파일 생성
cp .env.example .env

# 환경 변수 설정
API_URL=your_api_url
```

3. 앱 실행
```bash
# 개발 모드
flutter run

# 릴리즈 모드
flutter run --release
```

## 프로젝트 구조

```
lib/
  ├── screens/          # 화면 위젯
  │   ├── auth/        # 인증 관련 화면
  │   ├── calendar/    # 캘린더 관련 화면
  │   ├── records/     # 기록 관련 화면
  │   └── work/        # 근무 관련 화면
  ├── widgets/         # 재사용 가능한 위젯
  ├── models/          # 데이터 모델
  ├── providers/       # 상태 관리
  ├── repositories/    # 데이터 저장소
  ├── services/        # API 서비스
  ├── theme/           # 테마 설정
  └── utils/           # 유틸리티 함수
```

## API 문서

API 문서는 Swagger를 통해 제공됩니다:
- 개발 환경: http://localhost:3000/api
- 운영 환경: https://api.iris-app.com/api

### 주요 API 엔드포인트

#### 사용자 관리
- POST /users - 사용자 등록
- GET /users - 사용자 목록 조회
- GET /users/:id - 사용자 상세 조회
- PATCH /users/:id - 사용자 정보 수정
- DELETE /users/:id - 사용자 삭제

#### 근무 일정
- POST /work-schedules - 근무 일정 생성
- GET /work-schedules - 근무 일정 목록 조회
- GET /work-schedules/:id - 근무 일정 상세 조회
- PATCH /work-schedules/:id - 근무 일정 수정
- DELETE /work-schedules/:id - 근무 일정 삭제

#### 근무 요청
- POST /work-requests - 근무 요청 생성
- GET /work-requests - 근무 요청 목록 조회
- PATCH /work-requests/:id/approve - 근무 요청 승인
- PATCH /work-requests/:id/reject - 근무 요청 거절

## 디자인 가이드라인

- Clean UI/UX 디자인
- 토스 스타일 참고
  - 직관적인 네비게이션
  - 부드러운 애니메이션
  - 명확한 피드백
  - 일관된 디자인 시스템
- Material Design 3 기반
- 다크 모드 지원
- 반응형 디자인

## 기여 방법

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

## 연락처

- 이메일: your.email@example.com
- 프로젝트 링크: https://github.com/partoftrue/iris_flutter 