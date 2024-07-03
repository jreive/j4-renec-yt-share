class Api::UserController < ApplicationController
  respond_to :json
  before_action :authenticate_user!, only: [:validate]

  def validate
    response_status
  end
end
