class TestsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_test, only: [:show, :edit, :update, :destroy]

  respond_to :html, :pdf

  def index
    @tests = Test.where(author_id: current_user.id).order(created_at: :desc)
    # logger.debug(@tasks)
    if @tests.empty?
      redirect_to new_test_url
    else
      respond_with(@tests)
    end
  end

  def show
    respond_with(@test) do |format|
      format.pdf do
        render :pdf => "file_name", :template => 'tests/show.pdf.erb'
      end
    end
  end

  def new
    @test = Test.new
    @tags = UserTag.where(user_id: current_user.id)
    respond_with(@test)
  end

  def edit
    @tags = UserTag.where(user_id: current_user.id)
  end

  def create
    ActiveRecord::Base.transaction do
      @test = Test.new(test_params)
      @test.save
      update_student_tasks_for_test(@test)
    end
    respond_with(@test)
  end

  def update
    @test.update(test_params)
    update_student_tasks_for_test(@test)
    respond_with(@test)
  end

  def destroy
    @test.destroy
    respond_with(@test)
  end

  private
    def set_test
      @test = Test.find(params[:id])
    end

    def test_params
      default_params = {author_id: current_user.id}
      params.require(:test).permit(:student_id).merge default_params
    end

    def update_student_tasks_for_test(test)
      tasks_ids_line = params[:test][:tasks]
      if tasks_ids_line.nil?
        logger.debug('tasks == nil')
        raise InvalidUserData
      end

      task_id_tokens = tasks_ids_line.split(',')

      if task_id_tokens.empty?
        logger.debug('task_id_tokens empty')
        raise InvalidUserData
      end


      unless task_id_tokens.all? {|token| digits? token}
        logger.debug('nie ma tylko ids')
        raise InvalidUserData
      end

      task_ids = task_id_tokens.map &:to_i
      tasks = Task.where(id: task_ids, author_id: current_user.id).distinct

      unless tasks.size == task_ids.size
        console.debug(tasks)
        console.debug(task_ids)
        logger.debug('niezgodna ilosc ids')
        raise InvalidUserData
      end

      test.student_tasks.delete

      tasks.each do |task|
        student_task = StudentTask.new(student_id: test.student.id, task_id: task.id)
        student_task.save
        test.student_tasks << student_task
      end
    end

  def digits?(text)
    normalized = text.strip
    normalized.size == normalized.to_i.to_s.size
  end

end
