class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  rescue_from ActionController::InvalidAuthenticityToken, with: :invalid_auth_token
  rescue_from ActionController::ParameterMissing, with: :invalid_params
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_params

  def response_status(mess = 'Success', status = 200, error = false, data: nil)
    render(status: status,
           json: {
             code: status,
             error: error ? mess : nil,
             message: error ? nil : mess,
             data: data
           })
  end

  def invalid_params(str = nil)
    response_status('Invalid parameters', 400, true)
  end

  def invalid_auth_token
    response_status('Invalid login credentials', 401, true)
  end

  def forbidden
    response_status('Access denied', 403, true)
  end

end
