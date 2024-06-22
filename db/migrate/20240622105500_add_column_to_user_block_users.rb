class AddColumnToUserBlockUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :user_block_users, :is_verified, :boolean, default:false
  end
end
