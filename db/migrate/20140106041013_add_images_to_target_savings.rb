class AddImagesToTargetSavings < ActiveRecord::Migration
  def change
    add_column :target_savings, :images, :string
  end
end
