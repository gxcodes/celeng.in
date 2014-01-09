class DashboardController < ApplicationController
  before_filter :authenticate_user!, :transaction_mode 

  def index
    @events             = current_user.events
    @event              = Event.new
    @events += @target_savings
  end
  
end
