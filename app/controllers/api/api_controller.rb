module Api
  class Api::ApiController < ActionController::Base
    skip_before_action :verify_authenticity_token

    respond_to :json

    private

    def auth_and_set_user
      authenticate_or_request_with_http_basic do |u, p|
        @user = User.find_by(username: u)
        @user.try(:authenticate, p)
      end
    end

    def error(status, message = 'Something went wrong')
      response = {
        response_type: "ERROR",
        message: message
      }

      render json: response.to_json, status: status
    end
  end
end
