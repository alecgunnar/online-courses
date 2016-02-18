class InstructorController < ApplicationController
  before_action :force_instructor

  def index
    
  end

  private
    def force_instructor
      if not @launch_params.instructor?
        redirect_to lti_error_path, alert: 'You do not have permission to access this part of the application.'
      end
    end
end
