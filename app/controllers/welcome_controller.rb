class WelcomeController < ApplicationController
  skip_before_action :has_launched

  def index

  end
end
