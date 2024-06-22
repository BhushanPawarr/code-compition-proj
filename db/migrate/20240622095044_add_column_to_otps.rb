class AddColumnToOtps < ActiveRecord::Migration[7.0]
  def change
    add_column :user_block_otps, :expires_at, :datetime
  end
end
