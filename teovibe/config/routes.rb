Rails.application.routes.draw do
  # 인증
  resource :session
  resources :passwords, param: :token
  resource :registration, only: %i[new create]

  # 프로필
  get "me", to: "profiles#show", as: :me
  get "profile/edit", to: "profiles#edit", as: :edit_profile
  patch "profile", to: "profiles#update", as: :profile

  # 소셜 로그인
  get "auth/:provider/callback", to: "omniauth/sessions#create"
  get "auth/failure", to: "omniauth/sessions#failure"

  # 게시판 (카테고리별)
  resources :blogs, controller: "blogs"
  resources :tutorials, controller: "tutorials"
  resources :free_boards, controller: "free_boards"
  resources :qnas, controller: "qnas"
  resources :portfolios, controller: "portfolios"
  resources :notices, controller: "notices", only: %i[index show]

  # 게시글 공통 (새 글 작성 시 카테고리 선택)
  resources :posts, only: %i[new create]

  # 댓글
  resources :comments, only: %i[create destroy] do
    resource :like, only: %i[create destroy], module: :comments
  end

  # 좋아요
  resources :posts, only: [] do
    resource :like, only: %i[create destroy]
  end

  # 검색
  get "search", to: "search#index", as: :search

  # 정적 페이지
  get "about", to: "pages#about", as: :about
  get "consulting", to: "pages#consulting", as: :consulting

  # RSS 피드
  get "feed", to: "feeds#index", as: :feed, defaults: { format: :atom }

  # Admin
  namespace :admin do
    root to: "dashboard#index"
    resources :landing_sections do
      member do
        patch :move_up
        patch :move_down
        patch :toggle_active
      end
      resources :section_cards, except: %i[index]
    end
    resources :posts, only: %i[index show edit update destroy]
    resources :users, only: %i[index show edit update]
    resources :comments, only: %i[index destroy]
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root
  root "pages#home"
end
