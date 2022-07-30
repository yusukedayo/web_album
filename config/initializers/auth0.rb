# AUTH0_CONFIG = Rails.application.config_for(:auth0)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    ENV.fetch('auth0_client_id', nil),
    ENV.fetch('auth0_client_secret', nil),
    ENV.fetch('auth0_domain', nil),
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid profile'
    }
  )
end
