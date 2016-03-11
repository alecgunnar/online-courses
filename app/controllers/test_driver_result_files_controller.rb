class TestDriverResultFilesController < ApplicationController
  before_action :load_file

  def download
    send_file @file.path
  end

  def view

  end

  private
    def load_file
      @file = TestDriverResultFile.find_by_id params[:id]

      not_found if @file.nil?

      if @launch_params.user != @file.test_driver_result.submission.user and @launch_params.user != @file.test_driver_result.submission.assessment.user
        @message = t 'errors.general.no_permission'
        render 'general/error'
      end
    end
end
