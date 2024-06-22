class UserBlock::User < ApplicationRecord
	self.table_name = :user_block_users

	has_secure_password

	validates :name, :email, :role, :mobile_number, presence: true
	validates :name, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }, if: -> { name.present? }
	validates :mobile_number, format: { with: /\A[6-9]\d{9}\z/}, if: -> { mobile_number.present? }
	validates :email, :mobile_number, uniqueness: true
	validate :valid_email, if: -> { email.present? }
	
	enum role: ["admin","customer", "seller"]

	private
	def valid_email
      unless email =~ URI::MailTo::EMAIL_REGEXP
        errors.add(:email, ":  Invalid email format")
      end
    end
end
