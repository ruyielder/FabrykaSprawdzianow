class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html
  respond_to :json, only: :by_tags

  def index
    @tasks_user_tags = TaskUserTag.
        includes(:task, :user_tag).
        where('tasks.author_id = ?', current_user.id).
        order('user_tags.tag', 'tasks.created_at')
    if @tasks_user_tags.empty?
      redirect_to new_task_path
    else
      respond_with(@tasks_user_tags)
    end
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
    redirect_to tasks_path
  end

  def update
    @task.update(task_params)
    update_tags
    redirect_to tasks_path
  end

  def destroy
    @task.destroy
    respond_with(@task)
  end

  def by_tags
    tag_ids = params[:tags]
    unique_for = params[:unique_for]

    if unique_for and digits?(unique_for)
      student_id = unique_for.to_i
    else
      student_id = nil
    end

    task_limit = 20

    if tag_ids and student_id
      # suuuuuper slow :(
      ids = tag_ids.split(',').map(&:strip).map(&:to_i)
      puts 'IDS', ids.inspect
      tasks = Task.joins(:user_tags).where('user_tags.id' => ids, author_id: current_user.id).
          limit(task_limit).distinct
      ignored_student_tasks = StudentTask.where({student_id: student_id}).where({task_id: tasks})
      ignored_task_ids = Set.new ignored_student_tasks.map &:task_id
      @tasks = tasks.select {|task| not ignored_task_ids.include? task.id}
    elsif tag_ids
      ids = tag_ids.split(',').map(&:strip).map(&:to_i)
      @tasks = Task.joins(:user_tags).where('user_tags.id' => ids, author_id: current_user.id).
          limit(task_limit).distinct
    else
      @tasks = []
    end

    respond_with(@tasks)
  end

  private
    def set_task
      @task = Task.where(id: params[:id], author_id: current_user.id).first!
    end

    def task_params
      default_params = {author_id: current_user.id}
      params.require(:task).permit(:question, :answer, :extra_text, :tags_line).merge default_params
    end

    def update_tags
      line = @task.tags_line
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
        @task.user_tags << UserTag.where(user_id: current_user.id, tag: tag_name).first_or_create
      end
    end

    def get_tag_names(tags_line)
      Set.new (tags_line.split(',').map &:strip).select {|v| v.size > 0}
    end

    def digits?(text)
      normalized = text.strip
      normalized.size == normalized.to_i.to_s.size
    end
end
