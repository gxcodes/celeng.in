class SavingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @target_savings = current_user.target_savings
  end
  def create
    @target_saving  = TargetSaving.add_target params, current_user 
    debugger
  end
end
