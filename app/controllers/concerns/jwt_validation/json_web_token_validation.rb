# Jwt Token Module validation

module JwtValidation
  module JsonWebTokenValidation
    ERROR_CLASSES = [
      JWT::DecodeError,
      JWT::ExpiredSignature,
    ].freeze

    private

    def validate_json_web_token
      token = request.headers[:token] || params[:token]

      begin
        @token = WebToken::JsonWebToken.decode(token)
        @current_user = UserBlock::User.find(@token.id)
        @role =  @current_user.role
      rescue *ERROR_CLASSES => exception
        handle_exception exception
      end
    end

    def handle_exception(exception)
      case exception
      when JWT::ExpiredSignature
        return render_response(data: nil, errors: [token: 'Token has Expired'], message: "login fails", status: :unauthorized)
      when JWT::DecodeError
        return render_response(data: nil, errors: [token: 'Invalid token'], message: "login fails", status: :bad_request)
      end
    end
  end
end
