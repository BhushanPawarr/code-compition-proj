require 'rails_helper'
RSpec.describe UserBlock::ForgotPasswordController, type: :controller do
  describe 'POST #forgot' do
    before do 
      @user = FactoryBot.create(:user_block_user, email:"nksingh@gmail.com",password:"123456", name:"nitish", role:"admin", mobile_number:"7903378421")
    end
    it 'returns a success response with OTP number' do
      post :forgot, params: { email: @user.email }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Otp sent successfully...')
      expect(JSON.parse(response.body)['data']['otp_number']).not_to be_nil
    end

    it 'returns an error response for invalid email or mobile number' do
      post :forgot, params: { email: 'invalid@example.com' }
      expect(response.body).to include('Invalid email or mobile_number!')
    end
  end

  describe 'POST #verify_otp' do
    before do 
      @user = FactoryBot.create(:user_block_user, email:"nksingh@gmail.com",password:"123456", name:"nitish", role:"admin", mobile_number:"7903378421")
      @otp = FactoryBot.create(:user_block_otps, user_id: @user.id)
    end
    it 'returns a success response for valid OTP' do
      post :verify_otp, params: { email: @user.email, otp_number: @otp.otp_number }
      expect(response).to have_http_status(422)
    end
  end

 describe 'PUT #update_password' do
    before do 
      @user = FactoryBot.create(:user_block_user, email:"nksingh@gmail.com",password:"123456", name:"nitish", role:"admin", mobile_number:"7903378421",is_verified: true)
    end  
    it 'returns a success response for valid email and verified OTP' do   
    put :update_password, params: { email: @user.email, password: 'new_password' }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Your password updated successfully...')
    end
  end

end
