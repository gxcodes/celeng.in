class SavingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @target_savings = current_user.target_savings
    @target_saving = TargetSaving.new
    @total_income_all   = current_user.events.sum('income')
    @total_outcome_all  = current_user.events.sum('outcome')
    @total = @total_income_all - @total_outcome_all
    @total = @total_income_all - @total_outcome_all
    m = params['month'] || Time.now.month
    y = params['year'] || Time.now.year
    #debugger
    @total_income = current_user.events.by_month(m,year:y).sum('income')
    @total_expenses = current_user.events.by_month(m,year:y).sum('outcome')
    @total_month = @total_income - @total_expenses
  end
  def create
    @target_saving  = TargetSaving.add_target params, current_user 
    #debugger
  end
end
