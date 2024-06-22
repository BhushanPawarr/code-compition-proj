# spec/factories/user_block_otps.rb

FactoryBot.define do
  factory :user_block_otps, class: 'UserBlock::Otp'do
    user_id { 1 }
    otp_number { "123456" }
    expires_at { Time.now + 1.day }
  end
end
