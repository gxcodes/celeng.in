class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @events = Event.all
    @event  = Event.new
    @target_savings = TargetSaving.all
  end
end
