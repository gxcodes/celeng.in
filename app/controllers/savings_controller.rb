class SavingsController < ApplicationController
  before_filter :authenticate_user!, :transaction_mode 
  before_action :set_target_savings, only: [:show]#, :edit, :update]#, :destroy]

  def index
  end
  
  def new
    @target_saving = TargetSaving.new
  end

  def create
    @target_saving  = TargetSaving.add_target params, current_user 
    respond_to do |format|
      if @target_saving.save
        format.html { redirect_to savings_index_path, notice: 'Target Savings was successfully created.' }
      else
        format.html { redirect_to savings_index_path, alert: 'Name already exist. Please specify another name.' }
      end
    end
  end

  def destroy
    TargetSaving.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to savings_url }
    end
  end

  def clean
    TargetSaving.find(params[:id]).delete
    respond_to do |format|
      format.html { redirect_to savings_url }
    end
  end

  def edit
    @target_saving = TargetSaving.find(params[:id])
  end

  def update
    @target_saving = TargetSaving.find(params[:id])
    @target        = @target_saving.update_target params
    respond_to do |format|
      if @target.save
        format.html { redirect_to savings_index_path, notice: 'Target Savings was successfully updated.' }
      else
        format.html { redirect_to savings_index_path, alert: 'Name already exist. Please specify another name.' }
      end
    end
  end

  def finish
    @target = TargetSaving.find(params[:id])
    respond_to do |format|
      if @target.finish
        @target.update(completed: true, deadline: Time.now, name: "Expenses: #{@target.name}")
        format.html { redirect_to savings_index_path, notice: 'Target achieved! Expenses has been added automatically.' }
      else
        format.html { redirect_to savings_index_path, alert: 'Name already exist. Please specify another name.' }
      end
    end
  end

  # private
  #   def set_target_savings
  #     @target_saving = TargetSaving.find(params[:id])
  #   end

    # def target_savings_params
    #   params.require(:target_savings).permit(:name, :description, :url, :amount_target, :price, :deadline, :user_id, :images)
    # end
end
