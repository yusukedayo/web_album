# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_social_signed_in?

  def set_search
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).limit(4)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar face_id])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar face_id])
  end

  private

  def check_social_signed_in?
    return unless session[:userinfo].present?
    return if @current_user

    @current_user = User.find_by(social_unique_id: session[:userinfo]['sub']) || User.create!(name: session[:userinfo]['name'], email: "#{session[:userinfo]['sub']}@example.com",
                                                                                              password: SecureRandom.alphanumeric(10), avatar: session[:userinfo]['picture'], social_unique_id: session[:userinfo]['sub'])
    sign_in @current_user
  end
end
