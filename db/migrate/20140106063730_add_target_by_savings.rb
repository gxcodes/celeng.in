class AddTargetBySavings < ActiveRecord::Migration
  def change
    add_column :events, :savings, :integer, :default => 0
  end
end
