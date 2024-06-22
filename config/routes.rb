Rails.application.routes.draw do
  namespace :user_block do
    post 'register', to: 'register#create'
    get 'register/show'
    post 'sign_in/', to: 'login#sign_in'

    post 'forgot_password', to: 'forgot_password#forgot'
    post 'verify_otp', to: 'forgot_password#verify_otp'
    post 'update_password', to: 'forgot_password#update_password'

    
  end
  
end
