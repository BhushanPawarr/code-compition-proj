class CreateUserBlockUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :user_block_users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :role
      t.string :mobile_number

      t.timestamps
    end
  end
end
