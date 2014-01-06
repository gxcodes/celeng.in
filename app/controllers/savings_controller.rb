class SavingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @target_savings = current_user.target_savings
    @target_saving = TargetSaving.new
    @total_income_all   = current_user.events.sum('income')
    @total_outcome_all  = current_user.events.sum('outcome')
    @total = @total_income_all - @total_outcome_all
  end
  def create
    @target_saving  = TargetSaving.add_target params, current_user 
    #debugger
  end
end
