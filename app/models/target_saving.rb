class TargetSaving < ActiveRecord::Base
  belongs_to :user
  has_many :events
  
  
  def self.add_target params, current_user
    target_saving = TargetSaving.new
    target_saving.name = params['name']
    target_saving.amount_target = params['amount_target']
    target_saving.deadline = params['deadline']
    target_saving.user = current_user
    target_saving
  end
end
