class ApplicationController < ActionController::Base
  before_action :basic_authentication

  private
  
  def basic_authentication
      authenticate_or_request_with_http_basic do |user_name, password|
        user_name == 'title' && password == 'content'
    end
  end

end
