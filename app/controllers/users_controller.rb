class UsersController < ApplicationController
  skip_before_action :login_required,only: [:new, :create,:destroy]
  before_action :admin_user,     only: :destroy
  def new
      @user= User.new
  end
  def create
     @user=User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'ユーザを登録しました。'
       redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  def show
   @user=User.find(params[:id])
   @task = @user.tasks
  
   end
   def destroy
    @user=User.find(params[:id])
    @user.destroy
    flash[:danger] = "ユーザーを削除しました!"
     redirect_to admin_users_path
  end
  private
  def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
