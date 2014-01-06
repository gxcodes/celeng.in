class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @events = current_user.events
    @event  = Event.new
    @target_saving = TargetSaving.new
    @target_savings = current_user.target_savings
    @total_income_all   = current_user.events.sum('income')
    @total_outcome_all  = current_user.events.sum('outcome')
    @total = @total_income_all - @total_outcome_all
    m = params['month'] || Time.now.month
    y = params['year'] || Time.now.year
    #debugger
    @total_income = current_user.events.by_month(m,year:y).sum('income')
    @total_expenses = current_user.events.by_month(m,year:y).sum('outcome')
    @total_month = @total_income - @total_expenses
    # respond_to do |format|
    #   format.js { @tes = params['name'] }
    # end
    # debugger
    # @tes = params['name']
  end
end
