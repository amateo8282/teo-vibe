Rails.application.config.middleware.use OmniAuth::Builder do
  if ENV["GOOGLE_CLIENT_ID"].present?
    provider :google_oauth2,
      ENV["GOOGLE_CLIENT_ID"],
      ENV["GOOGLE_CLIENT_SECRET"],
      scope: "email,profile"
  end

  if ENV["KAKAO_CLIENT_ID"].present?
    provider :kakao,
      ENV["KAKAO_CLIENT_ID"],
      ENV["KAKAO_CLIENT_SECRET"]
  end
end

OmniAuth.config.allowed_request_methods = [:post]
