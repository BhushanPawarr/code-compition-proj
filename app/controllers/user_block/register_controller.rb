module UserBlock
  class RegisterController < ApplicationController
    
    def create
      user = UserBlock::User.new(user_params)
      if user.save
        render_response(data: UserBlock::UserSerializer.new(user).serializable_hash, message: "User Registered Successfully...", status: :ok)
      else
        render_response(data:nil, errors:user.errors.full_messages, message: "Registration failed !", status:422)
      end
    end

    private 

    def user_params
      params.require(:user).permit(:name, :password, :email, :mobile_number, :role)
    end
  end
end
