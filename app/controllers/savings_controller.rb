class SavingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @target_savings = current_user.target_savings
  end
end
