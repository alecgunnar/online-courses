class TestDriversController < ApplicationController
  before_action :load_assessment, only: [:add, :create]
  before_action :load_test_driver, only: [:edit, :update]

  def download
    driver = TestDriver.find_by_id params[:id]

    not_found if driver.nil? or (not driver.downloadable)

    send_file driver.file.url
  end

  def add
    @test_driver = TestDriver.new

    render 'form'
  end

  def create
    @test_driver = TestDriver.new test_driver_params

    if @test_driver.valid?
      @test_driver.assessment = @assessment
      @test_driver.save

      return redirect_to root_path
    end

    render 'form'
  end

  def edit
    render 'form'
  end

  def update
    @test_driver.attributes = test_driver_params

    if @test_driver.valid?
      @test_driver.save

      return redirect_to root_path
    end

    render 'form'
  end

  private
    def load_assessment
      @assessment = Assessment.find_by id: params[:id]

      not_found if @assessment.nil?
      no_permision if @session.user != @assessment.instructor
    end

    def load_test_driver
      @test_driver = TestDriver.find_by id: params[:id]

      not_found if @test_driver.nil?
    end

    def test_driver_params
      params.require(:test_driver).permit(:file, :points, :downloadable, test_driver_files_attributes: [:id, :name, :points, :_destroy])
    end
end
