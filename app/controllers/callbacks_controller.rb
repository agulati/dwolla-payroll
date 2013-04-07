class CallbacksController < ApplicationController

  def dwolla_oauth

    if params && params["code"]
      token = Dwolla::Client.get_token(params['code'])
      redirect_to dashboard_path
    end

  end
end