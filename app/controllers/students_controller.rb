class StudentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_student, only: [:edit, :update, :destroy]

  respond_to :html

  def index
    @students = Student.where(teacher_id: current_user.id).order(created_at: :desc)
    respond_with(@students)
  end

  def new
    @student = Student.new
    respond_with(@student)
  end

  def edit
  end

  def create
    @student = Student.new(student_params)
    @student.save
    redirect_to students_path
  end

  def update
    @student.update(student_params)
    redirect_to students_path
  end

  def destroy
    @student.destroy
    respond_with(@student)
  end

  private
    def set_student
      @student = Student.where(id: params[:id], teacher_id: current_user.id).first!
    end

    def student_params
      default_params = {teacher_id: current_user.id}
      params.require(:student).permit(:name).merge default_params
    end
end
