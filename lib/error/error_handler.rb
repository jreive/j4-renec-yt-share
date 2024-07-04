# Error module to Handle errors globally

# include Error::ErrorHandler in application_controller.rb

module Error
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from ActiveRecord::RecordNotFound do |e|
          respond(e.message, 404, true)
        end
        rescue_from ActionController::InvalidAuthenticityToken do
          response_status('Invalid login credentials', 401, true)
        end
        rescue_from ActionController::ParameterMissing do
          response_status('Invalid parameters', 400, true)
        end
        rescue_from ActiveRecord::RecordNotFound do |e|
          respond(e.message, 404, true)
        end
        rescue_from ActiveRecord::ActiveRecordError do |e|
          respond(e.message, 500, true)
        end
        rescue_from StandardError do |e|
          respond(e.message, 500, true)
        end
      end
    end

    def respond(mess = 'Success', status = 200, error = false, data: nil)
      render(status: status,
             json: {
               code: status,
               error: error ? mess : nil,
               message: error ? nil : mess,
               data: data
             })
    end
  end
end