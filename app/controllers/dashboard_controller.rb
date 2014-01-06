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
    # respond_to do |format|
    #   format.js { @tes = params['name'] }
    # end
    # debugger
    # @tes = params['name']
  end
end
