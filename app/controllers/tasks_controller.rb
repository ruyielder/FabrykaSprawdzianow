class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html

  def index
    @tasks = Task.where(author_id: current_user.id)
    respond_with(@tasks)
  end

  def show
    respond_with(@task)
  end

  def new
    @task = Task.new
    respond_with(@task)
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.save
    respond_with(@task)
  end

  def update
    @task.update(task_params)
    respond_with(@task)
  end

  def destroy
    @task.destroy
    respond_with(@task)
  end

  private
    def set_task
      @task = Task.where(id: params[:id], author_id: current_user.id).first!
    end

    def task_params
      default_params = {author_id: current_user.id}
      params.require(:task).permit(:question, :answer).merge default_params
    end
end
