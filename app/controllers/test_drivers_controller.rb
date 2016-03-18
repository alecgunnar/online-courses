class TestDriversController < ApplicationController
  def download
    driver = TestDriver.find_by_id params[:id]

    not_found if driver.nil? or (not driver.downloadable)

    send_file driver.file.url
  end
end
