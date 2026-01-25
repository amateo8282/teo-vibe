# Feature Breakdown 커맨드

기존 플랜을 기반으로 문제나 기능을 작은 태스크로 분해합니다.

## 입력

$ARGUMENTS

## 수행 작업

### 1. 기존 플랜 분석

먼저 `docs/plans/` 디렉토리의 기존 플랜 문서들을 확인하세요:
- `Plan.md`: 전체 계획
- `PRD.md`: 제품 요구사항
- `TRD.md`: 기술 요구사항
- `TASK.md`: 기존 태스크 목록

### 2. 클린 아키텍처 계층별 분석

입력된 문제/기능을 다음 계층으로 분류하세요:

1. **Domain Layer (도메인 계층)**
   - 필요한 엔티티, 값 객체
   - 도메인 서비스 및 비즈니스 규칙

2. **Application Layer (애플리케이션 계층)**
   - 유스케이스 정의
   - 필요한 인터페이스 (Repository, Service)

3. **Infrastructure Layer (인프라 계층)**
   - 외부 API, 데이터베이스 연동
   - Repository 구현

4. **Presentation Layer (프레젠테이션 계층)**
   - UI 컴포넌트
   - 상태 관리, 사용자 상호작용

### 3. TDD 연계 태스크 도출

각 계층에 대해 TDD 사이클(Red-Green-Refactor)을 적용한 태스크를 생성하세요.

### 4. 출력 형식

각 태스크는 다음 형식으로 출력하세요:

```markdown
## 태스크 [번호]: [태스크 제목]

**계층**: [Domain/Application/Infrastructure/Presentation]

**설명**: [태스크에 대한 상세 설명]

**TDD 단계**:
1. Red: [실패하는 테스트 작성 내용]
2. Green: [테스트 통과를 위한 최소 구현]
3. Refactor: [리팩토링 포인트]

**완료 조건**:
- [ ] [구체적인 완료 조건 1]
- [ ] [구체적인 완료 조건 2]

**의존성**: [선행 태스크 번호 또는 "없음"]

**커밋 메시지**: `[한글로 작성된 커밋 메시지]`
```

### 5. 우선순위 및 순서

태스크는 다음 순서로 정렬하세요:
1. Domain 계층 (의존성 없음)
2. Application 계층 (Domain에 의존)
3. Infrastructure 계층 (Application 인터페이스 구현)
4. Presentation 계층 (모든 계층 통합)

---

## 실행

위 지침에 따라 "$ARGUMENTS"를 분석하고 태스크로 분해하세요.
기존 `docs/plans/` 문서가 있다면 참조하고, 없다면 새로운 분석을 수행하세요.
