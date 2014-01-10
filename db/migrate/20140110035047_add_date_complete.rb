class AddDateComplete < ActiveRecord::Migration
  def change
    add_column :target_savings, :date_completed, :datetime
  end
end
