class TasksController < ApplicationController
  # before_action :basic_authentication, only: :show
  before_action :check_user, only: %i[edit update destroy]
  before_action :set_task, only: %i[show  edit update destroy]
  def index
    if params[:sort_expired]
      @tasks = Task.all.page(params[:page]).per(3).order(expired_at: :desc)
    elsif params[:title].present?
      if params[:status].present?
        @tasks = Task.all.task_name_search(params[:title]).status_search(params[:status]).page(params[:page]).per(10)
      else
        @tasks = Task.all.task_name_search(params[:title]).page(params[:page]).per(3)
      end
    elsif params[:status].present?
      @tasks = Task.all.status_search(params[:status]).page(params[:page]).per(3)
    elsif params[:label_id].present?
      @tasks = Task.all.joins(:labels).where(labels: { id: params[:label_id] }).page(params[:page]).per(2)
    elsif params[:sort_priority]
      @tasks = Task.all.page(params[:page]).per(3).order(priority: :desc)
    else
      @tasks = Task.all.includes(:user).page(params[:page]).per(3).order(created_at: :desc)
    end
  end
  def new
    @task =Task.new
  end
  def create
    @task = current_user.tasks.create(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "タスクを作成しました!"      
      else
        render :new
      end
    end
  end
  def show
    @tasks = Task.where(user_id: @task.user.id).order(created_at: :desc)
  end
  def edit
  end
  def update
   if @task.update(task_params)
    redirect_to tasks_path, notice: "タスクを編集しました！"
   else
    render :edit
   end
  end
  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end
  private
  def task_params
    params.require(:task).permit(
       :title,
       :content,
       :expired_at,
       :status,
       :priority,
       { label_ids: [] } 
      )
  end
  def set_task
    @task = Task.find(params[:id])
  end
  def check_user
    if @current_user.nil?
     redirect_to new_session_path unless logged_in?
    end
  end
end







