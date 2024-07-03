# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  respond_to :json

  private
  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: {code: 200, error: 'Signed up sucessfully.'},
        data: resource
      }
    else
      render json: {
        status: {error: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end
end
