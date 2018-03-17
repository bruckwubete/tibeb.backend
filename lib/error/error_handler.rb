module Error
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        # rescue_from StandardError do |e|
        #   respond(:internal_server_error, 500, e.to_s)
        # end
        rescue_from Mongoid::Errors::DocumentNotFound do |e|
          respond(:record_not_found, 404, e.as_json['problem'])
        end
        rescue_from CustomError do |e|
          respond(e.error, e.status, e.message.to_s)
        end

        rescue_from ArgumentError do |e|
          respond(:argument_error, 400, e.to_s)
        end
      end
    end

    private

    def respond(_error, _status, _message)
      json = Helpers::Render.json(_error, _status, _message)
      render json: json, status: _status
    end
  end
end
