class Event < ActiveRecord::Base
  by_star_field :start_time
  belongs_to :target_saving
  belongs_to :user
  def self.add param, current_user
    @event = Event.new
    
    if param[:transaksi] == "add_income" 
      @event.income   = param[:amount].to_i
      @event.name = "Income"
    elsif param[:transaksi] == "add_saving"
      @event.target_saving_id = param[:target][:target_savings]
      @event.income   = param[:amount].to_i
      @event.name = "Savings"
    elsif param[:transaksi] == "add_outcome"
      @event.outcome  = param[:amount].to_i
      @event.name = "Expenses"
    end
    @event.start_time = param[:date]
    @event.user = current_user
    @event
  end
end
