class ApplicationController < ActionController::API
	include JwtValidation::JsonWebTokenValidation

    def render_response(data:, message: nil, status: :ok, errors: {})
      response_data = {
        status: status == :ok,
        data: data,
        message: message,
        errors: errors
      }
      render json: response_data, status: status
    end

    def validate_role_admin
      if @role.admin?
        return true
      else
        render_response(data: nil, errors: "Not allow to perform this action", message: "Only Admin can perform this action")
      end
    end

    def validate_role_customer
      if @role.customer?
        return true
      else
        render_response(data: nil, errors: "Not allow to perform this action", message: "Only Customer can perform this action")
      end
    end

    def validate_role_seller
      if @role.seller?
        return true
      else
        render_response(data: nil, errors: "Not allow to perform this action", message: "Only Seller can perform this action")
      end
    end

  rescue_from StandardError, with: :handle_exception

    def handle_exception(exception)
      render json: { error: exception.message }, status: :internal_server_error
    end
    
end
