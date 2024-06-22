class UserBlock::Otp < ApplicationRecord
	self.table_name = :user_block_otps
	
	validates :otp_number, presence: true 
end