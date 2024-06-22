require 'rails_helper'

RSpec.describe UserBlock::LoginController, type: :controller do
  describe "POST /sign_in" do
    before do 
      @user = FactoryBot.create(:user_block_user, email:"nksingh@gmail.com",password:"123456", name:"nitish", role:"admin", mobile_number:"7903378421")
    end
    it "login existing user" do  
      post :sign_in, params:{email:"nksingh@gmail.com", password:"123456"}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Login successfully...")      
    end

    it "login user with wrong email" do  
      post :sign_in, params:{email:"nksingh1@gmail.com", password:'123456'}
      expect(response).to have_http_status(401)
    end

    it "login user with wrong password" do  
      post :sign_in, params:{email:"nksingh@gmail.com", password:'12345'}
      expect(response).to have_http_status(401)
    end
  end
end
