class AddColumnComplete < ActiveRecord::Migration
  def change
    add_column :target_savings, :completed, :boolean, :default => false
  end
end
