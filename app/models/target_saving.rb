class TargetSaving < ActiveRecord::Base
  belongs_to :user
  has_many :events, dependent: :destroy
  mount_uploader :images, ImagesUploader

  validates :name, uniqueness: {scope: :user_id}, presence: true
  validates :deadline, presence:true
  validates :price, presence:true 
  
  def self.add_target params, current_user
    target_saving               = TargetSaving.new
    target_saving.name          = params['name']
    target_saving.amount_target = params['amount_target']
    target_saving.deadline      = params['deadline']
    target_saving.user          = current_user
    target_saving.url           = params['url']
    target_saving.description   = params['description']
    target_saving.images        = params['images']
    target_saving
  end
  def update_target params
    TargetSaving.transaction do
      target_saving = TargetSaving.lock.find_by_id params[:id]
      target_saving.name          = params['name']
      target_saving.amount_target = params['amount_target']
      target_saving.deadline      = params['deadline']
      target_saving.url           = params['url']
      target_saving.description   = params['description']
      target_saving.images        = params['images']
      target_saving 
    end
  end

  def finish
    self.events.each {|event| event.update(outcome: event.savings, savings: 0) }  
  end

  def start_time
    if date_completed == nil
      deadline
    else
      date_completed
    end
  end
  def amount
    amount_target
  end
end
