# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar face_id])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar face_id])
  end

  private

  def user_signed_in?
    session[:userinfo].present?
  end

  def authenticate_user!
    if user_signed_in?
      return if @current_user

      @current_user = User.find_by(social_unique_id: session[:userinfo]['sub']) || User.create!(name: session[:userinfo]['name'], email: "#{session[:userinfo]['sub']}@example.com",
                                                                                                password: SecureRandom.alphanumeric(10), avatar: session[:userinfo]['picture'], social_unique_id: session[:userinfo]['sub'])
    else
      redirect_to login_path
    end
  end

  attr_reader :current_user
end
