module ApplicationHelper
  def require_admin
  unless logged_in? && current_user.admin == true
    redirect_to tasks_path, flash[:danger] = "管理者以外はアクセスできない"
   end
  end
end
