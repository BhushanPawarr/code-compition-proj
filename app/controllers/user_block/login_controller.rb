module UserBlock
  class LoginController < ApplicationController

#User login api

    def sign_in
      account = UserBlock::User
          .where('LOWER(email) = ?', login_params[:email] )
          .first
        if account.present?
          if account&.authenticate( login_params[:password])
            token = generate_tokens(account.id)
            data= { account: UserBlock::UserSerializer.new(account).serializable_hash, token: token }
            render_response(data: data, message: "Login successfully...", status: :ok)
          else
          render_response(data: nil, message: "Invalid password !, please check your password", status:401)
          end
        else
          render_response(data: data, message: "Invalid email !, check your mail", status:401)
        end
    end
    private

    def generate_tokens id
      WebToken::JsonWebToken.encode(id, 1.day.from_now, token_type: 'login')
    end

    def login_params
      params.permit(:email,:password)
    end

  end
end

