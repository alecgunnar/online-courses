class ManageController < ApplicationController
  before_action :force_instructor

  def index
    
  end

  private
    def force_instructor
      if not @launch_params.instructor?
        redirect_to launch_error_path, alert: t('errors.launch.not_permitted')
      end
    end
end
