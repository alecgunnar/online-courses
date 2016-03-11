class TestDriverController < ApplicationController
  def download
    driver = TestDriver.find_by_id params[:id]

    not_found if driver.nil?

    send_file "#{Rails.root}/spikes/#{driver.name}"
  end
end
