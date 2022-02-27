class ApplicationController < ActionController::Base
  # before_action :basic_authentication
  # private
  # def basic_authentication
  #     authenticate_or_request_with_http_basic do |user_name, password|
  #       user_name == 'title' && password == 'content'
  #   end
  # end
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required

  private

  def login_required
    redirect_to new_session_path unless current_user
  end

end
