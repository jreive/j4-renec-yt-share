class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  include Error::ErrorHandler

  def response_status(mess = 'Success', status = 200, error = false, data: nil)
    render(status: status,
           json: {
             code: status,
             error: error ? mess : nil,
             message: error ? nil : mess,
             data: data
           })
  end

  def forbidden
    response_status('Access denied', 403, true)
  end
end
