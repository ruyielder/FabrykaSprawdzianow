class TestsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_test, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @tests = Test.where(author_id: current_user.id)
    respond_with(@tests)
  end

  def show
    respond_with(@test)
  end

  def new
    @test = Test.new
    respond_with(@test)
  end

  def edit
  end

  def create
    @test = Test.new(test_params)
    @test.save
    respond_with(@test)
  end

  def update
    @test.update(test_params)
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
end
