class TestDriverResultFilesController < ApplicationController
  before_action :load_file

  def download
    no_permission if not @file.test_driver_file.downloadable and not @session.instructor?

    send_file @file.path
  end

  private
    def load_file
      @file = TestDriverResultFile.find_by_id params[:id]

      not_found if @file.nil?

      if @session.user != @file.test_driver_result.submission.user and @session.user != @file.test_driver_result.submission.assessment.instructor
        @message = t 'errors.general.no_permission'
        render 'general/error'
      end
    end
end
