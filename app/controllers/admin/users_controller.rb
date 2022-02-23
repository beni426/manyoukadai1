class Admin::UsersController < ApplicationController
 skip_before_action :login_required, only: %i[new create] 
  before_action :if_not_admin
  before_action :set_user, only: %i[show edit update destroy]  
  before_action :check_user, only: %i[edit update destroy] 
  def index
  @users = User.all
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
    session[:user_id] = @user.id
    redirect_to @user, notice: "アカウント作成しました!"
   else
    render :new
    end
  end
  def show
  end
  def edit
  end

  def update
   if @user.update(user_params)
     redirect_to @user, notice: "ユーザー情報を編集しました!"
   else
     render :edit
   end
  end
  def destroy
    @user.destroy
    flash[:danger] = "ユーザーを削除しました!"
     redirect_to new_user_path
  end
  private
  def user_params
    params.require(:user).permit(:name, :email,
       :password, :password_confirmation, :image, :image_cache)
  end
  def set_user
    @user = User.find(params[:id])
  end
 
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end
end
