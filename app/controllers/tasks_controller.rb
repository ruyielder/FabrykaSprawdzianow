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
    update_tags
    respond_with(@task)
  end

  def update
    @task.update(task_params)
    update_tags
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

    def update_tags
      line = params[:task][:tags_line]
      tag_names = get_tag_names(line)
      tags = @task.user_tags
      mapping_tags = {}
      tags.each {|tag| mapping_tags[tag.tag] = tag }
      used_tag_names = Set.new(tags.map &:tag)
      unused_tag_names = used_tag_names - tag_names
      unused_tag_names.each do |tag_name|
        mapping_tags[tag_name].destroy
      end
      new_tag_names = tag_names - used_tag_names
      new_tag_names.each do |tag_name|
        @task.user_tags << make_tag(tag_name)
      end
    end

    def get_tag_names(tags_line)
      Set.new (tags_line.split(',').map &:strip).select {|v| v.size > 0}
    end

    def make_tag(text)
      user_tag = UserTag.new
      user_tag.user = current_user
      user_tag.tag = text
      user_tag.save
      user_tag
    end
end
