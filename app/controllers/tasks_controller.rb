class TasksController < ApplicationController
  # before_action :basic_authentication, only: :show
  before_action :set_task, only: %i[show  edit update destroy]
  def index
    if params[:sort_expired]
      @tasks = Task.all.order(expired_at: :desc)
    elsif params[:title].present?
      if params[:status].present?
        @tasks = Task.all.task_name_search(params[:title]).status_search(params[:status])
        
      else
        @tasks = Task.all.task_name_search(params[:title])
      end
    elsif params[:status].present?
      @tasks = Task.all.status_search(params[:status])
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :desc)
    else
      @tasks = Task.all.order(created_at: :desc)
    end
  end
  def new
    @task =Task.new
  end
  def create
    @task = Task.new(task_params)
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
       :priority 
      )
  end
  def set_task
    @task = Task.find(params[:id])
  end
end







