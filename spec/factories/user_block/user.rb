FactoryBot.define do
  factory :user_block_user, class: 'UserBlock::User' do
    name {"nithu"}
    email {"nithu@gmail.com"}
    password {"password"}
    role {1}
    mobile_number {"7903378433"}
    
  end
end
