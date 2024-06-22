class CreateUserBlockOtps < ActiveRecord::Migration[7.0]
  def change
    create_table :user_block_otps do |t|
      t.integer :user_id
      t.string :otp_number

      t.timestamps
    end
  end
end
