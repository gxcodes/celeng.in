class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @events = current_user.events
    @event  = Event.new
    @target_saving = TargetSaving.new
    @target_savings = current_user.target_savings
    @total_income_all   = current_user.events.sum('income')
    @total_saving_all   = current_user.events.sum('savings')
    @total_outcome_all  = current_user.events.sum('outcome')
    @total = @total_income_all - @total_outcome_all
    @residue = @total - @total_saving_all
    m = params['month'] || Time.now.month
    y = params['year'] || Time.now.year
    @total_income = current_user.events.by_month(m,year:y).sum('income')
    @total_saving   = current_user.events.by_month(m,year:y).sum('savings')
    @total_expenses = current_user.events.by_month(m,year:y).sum('outcome')
    @total_month = @total_income - @total_expenses
  end
  
end
