class Api::UserController < ApplicationController
  respond_to :json
  before_action :authenticate_user!, only: [:validate]

  def validate
    response_status('Success', 200, false, data: current_user)
  end

  def check
    email = params.require(:email)
    user = User.find_by_email(email)
    if user
      response_status('Email already taken', 422, true)
    else
      response_status('Email valid to signup')
    end
  rescue ActiveRecord::ActiveRecordError, StandardError => e
    response_status(e.message, 500, true)
  end
end
