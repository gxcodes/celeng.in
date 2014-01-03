class SavingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @target_savings = TargetSaving.all
  end
end
