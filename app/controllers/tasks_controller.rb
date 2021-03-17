class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.order_by_created_at(params[:created_at]).order_by_end_time(params[:end_time])
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
    params.require(:task).permit(:title, :description, :priority, :status, :start_time, :end_time)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
