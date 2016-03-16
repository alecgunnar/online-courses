class TestDriversController < ApplicationController
  def download
    driver = TestDriver.find_by_id params[:id]

    not_found if driver.nil?

    send_file "#{Rails.root}/spikes/#{driver.name}"
  end

  def new
    @driver = TestDriver.new
    render 'form'
  end

  def create
    @driver = TestDriver.new
    @driver.attributes = test_driver_params
    @driver.save!
    redirect_to root_path
  end

  def edit
    @driver = TestDriver.find_by_id params[:id]
    render 'form'
  end

  def update
    @driver = TestDriver.find_by_id params[:id]
    @driver.update! test_driver_params
    redirect_to root_path
  end

  def delete
    @driver = TestDriver.find_by_id params[:id]
    @driver.destroy
    redirect_to root_path
  end

  private
    def test_driver_params
      params.require(:test_driver).permit(:name, :points, :file)
    end
end
