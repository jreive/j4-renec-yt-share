class ErrorsController < ApplicationController
  respond_to :json

  def not_found
    response_status('Well, well, well, there have nothing here', :not_found, true)
  end

  def internal_server_error
    response_status('Call an ambulance now! We have an accident!', :internal_server_error, true)
  end
end