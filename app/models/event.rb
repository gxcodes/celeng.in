class Event < ActiveRecord::Base
  by_star_field :start_time
  belongs_to :target_saving
  belongs_to :user

  validates :income, presence:true
  validates :outcome, presence:true

  def self.add param, current_user
    @event = Event.new
    if param[:transaksi] == "add_income" 
      @event.income     = param[:amount].to_i
      if param[:name] == "" || param[:name] == nil
        @event.name       = "Income: #{param[:amount]}"
      else
        @event.name       = "Income: #{param[:name]}"
      end
    elsif param[:transaksi] == "add_outcome"
      if param[:name] == "" || param[:name] == nil
        @event.name       = "Expenses: #{param[:amount]}"
      else
        @event.name       = "Expenses: #{param[:name]}"
      end
      @event.outcome    = param[:amount].to_i
    elsif param[:transaksi] == "add_saving"
      @event.target_saving_id = param[:target][:target_savings]
      @event.savings    = param[:amount].to_i
      @event.name       = "Savings: #{TargetSaving.find_by_id(param[:target][:target_savings]).name}"
    end
    @event.start_time   = param[:date]
    @event.user         = current_user
    @event.description  = param['description']
    @event
  end

  def self.check_balance event
    @before_saving = event.target_saving.amount_target - event.target_saving.events.sum('savings')
    if @before_saving >= event.savings || event.savings == 0
      true
    else
      false
    end
  end

  def finish target, current_user
    self.outcome      = target.amount_target
    self.name         = "Add Expenses"
    self.start_time   = Time.now
    self.user         = current_user
    self.description  = "Buy "+target.name
    self
  end

  def amount
    # income > 0 ? income : (outcome > 0 ? outcome : savings )
    if income > 0
      income
    elsif outcome > 0
      outcome
    else
       savings 
    end
  end
end
