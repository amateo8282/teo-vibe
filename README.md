# TeoVibe - 바이브코딩 브랜딩 & 커뮤니티 플랫폼

바이브코딩으로 사업을 만드는 과정을 기록하고, 같은 여정을 걷는 사람들과 함께 성장하는 커뮤니티 플랫폼입니다.

## 기술 스택

| 분류 | 기술 |
|------|------|
| 프레임워크 | Rails 8.1 + Ruby 3.3 |
| 데이터베이스 | SQLite (WAL 모드) |
| 프론트엔드 | Hotwire (Turbo + Stimulus) |
| CSS | Tailwind CSS v4 (tailwindcss-rails) |
| 에셋 | Propshaft + Import Maps |
| 인증 | Rails 빌트인 인증 + OmniAuth (Google, Kakao) |
| 리치 텍스트 | ActionText |
| 페이지네이션 | Pagy v43 |
| SEO | meta-tags gem + sitemap_generator |
| 배포 | Kamal 2 |

## 주요 기능

### Phase 1: 인증 시스템
- 이메일/비밀번호 회원가입, 로그인, 로그아웃
- 소셜 로그인 (Google, Kakao) - OmniAuth
- 프로필 조회/수정

### Phase 2: 게시판 시스템
- 6개 카테고리: 블로그, 튜토리얼, 자유게시판, Q&A, 포트폴리오, 공지사항
- ActionText 리치 텍스트 에디터
- 댓글 (대댓글 지원) + Turbo Stream 실시간
- 좋아요 (게시글/댓글)
- 검색 (제목/본문 SQLite LIKE)
- RSS/Atom 피드

### Phase 3: 랜딩 페이지 + 관리자
- 동적 랜딩 페이지 (DB에서 섹션 관리)
- memoir 톤앤매너 디자인 (크림 톤, 대담한 타이포, pill 버튼)
- 관리자 패널 (대시보드, 랜딩 섹션/게시글/사용자/댓글 관리)
- SEO: JSON-LD, Open Graph, sitemap.xml, robots.txt

## 로컬 개발

```bash
# Ruby 3.3 설치 (rbenv)
rbenv install 3.3.10
rbenv local 3.3.10

# 의존성 설치
cd teovibe
bundle install

# DB 마이그레이션 + 시드
bin/rails db:migrate
bin/rails db:seed

# Tailwind CSS 빌드
bin/rails tailwindcss:build

# 서버 실행
bin/rails server
```

관리자 계정: `admin@teovibe.com` / `password123`

## 디자인 시스템

memoirapp.com의 톤앤매너를 차용하여 재구성한 디자인:

- 배경: 크림 (#F5F1EA)
- 주요 CTA: 골드 (#F4BA54)
- 포인트: 오렌지 (#E86221)
- 본문: 다크 (#1D1403)
- 폰트: Pretendard (CDN)
- 버튼: pill 형태 (rounded-full)
- 카드: rounded-3xl

## 프로젝트 구조

```
teovibe/
├── app/
│   ├── controllers/
│   │   ├── posts_base_controller.rb  # 공통 게시판 CRUD
│   │   ├── blogs_controller.rb       # 카테고리별 컨트롤러
│   │   ├── comments_controller.rb    # Turbo Stream 댓글
│   │   ├── likes_controller.rb       # 좋아요 토글
│   │   └── admin/                    # 관리자 패널
│   ├── models/
│   │   ├── user.rb                   # 인증 + 역할
│   │   ├── post.rb                   # 게시글 (6 카테고리)
│   │   ├── comment.rb                # 대댓글 구조
│   │   ├── like.rb                   # 다형성 좋아요
│   │   └── landing_section.rb        # 동적 랜딩 섹션
│   └── views/
│       ├── pages/sections/           # 랜딩 페이지 섹션
│       ├── posts/                    # 게시판 공통 뷰
│       └── admin/                    # 관리자 뷰
├── config/
│   ├── routes.rb
│   └── sitemap.rb
└── db/
    └── seeds.rb                      # 초기 데이터
```
