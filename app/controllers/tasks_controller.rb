class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    if params[:order]
      case params[:order]
      when "created_asc"
        @tasks = Task.created_time_asc
      when "created_desc"
        @tasks = Task.created_time_desc
      end
    else
      @tasks = Task.all
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice: t('.notice')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: t('.notice')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: t('.notice')
  end

  private
  def task_params
    params.require(:task).permit(:title, :description)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
