class Auth0Controller < ApplicationController
  def callback
    auth_info = request.env['omniauth.auth']
    session[:userinfo] = auth_info['extra']['raw_info']

    redirect_to '/graduation_albums'
  end

  def failure
    @error_msg = request.params['message']
  end

  def logout
    reset_session
    redirect_to logout_url
  end

  private

  AUTH0_CONFIG = Rails.application.config_for(:auth0)

  def logout_url
    request_params = {
      returnTo: root_url,
      client_id: AUTH0_CONFIG['auth0_client_id']
    }

    URI::HTTPS.build(host: AUTH0_CONFIG['auth0_domain'], path: '/v2/logout', query: to_query(request_params)).to_s
  end

  def to_query(hash)
    hash.map { |k, v| "#{k}=#{CGI.escape(v)}" unless v.nil? }.compact.join('&')
  end
end
