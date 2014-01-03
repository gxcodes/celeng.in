class AddUserIdTargetSavings < ActiveRecord::Migration
  def change
    add_column :target_savings, :user_id, :integer
  end
end
