class Account::D2lController < ApplicationController
  include D2lApi

  def index

  end

  def forward
    redirect_to auth_url
  end

  def tokens
    supplied_params = token_params

    if supplied_params.length == 3
      current_user.update({ token_id: supplied_params[:x_a], token_key: supplied_params[:x_b], token_sig: supplied_params[:x_c] })

      redirect_to account_api_auth_path, notice: 'Your account has been authenticated!'
    else
      redirect_to account_api_auth_path, alert: 'Could not authenticate your account.'
    end
  end

  private
    def token_params
      params.permit :x_a, :x_b, :x_c
    end
end
