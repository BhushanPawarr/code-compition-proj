require 'rails_helper'

RSpec.describe UserBlock::RegisterController, type: :controller do
  describe "POST /create" do
    it "creating new user" do  
      post :create, params:{user:{name:"nitish", email:"nksingh@gmail.com", password:"123456", mobile_number:"7903378421", role:"admin"}}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("User Registered Successfully...")      
    end

    it "creating new user" do  
      post :create, params:{user:{name:"nitish", email:"nksingh@gmail.com", password:' ',location:"hyderabad"}}
      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)["message"]).to eq("Registration failed !")      
    end
  end
end
