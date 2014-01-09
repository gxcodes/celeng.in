class SavingsController < ApplicationController
  before_filter :authenticate_user! 
  before_action :set_target_savings, only: [:show]#, :edit, :update]#, :destroy]

  def index
    @target_savings     = current_user.target_savings.joins('LEFT JOIN events ON target_savings.id = events.target_saving_id').group('target_savings.name').select("target_savings.* , sum(events.savings) as jumlah").order(deadline: :asc)
    @target_saving      = TargetSaving.new
    @total_income_all   = current_user.events.sum('income')
    @total_saving_all   = current_user.events.sum('savings')
    @total_outcome_all  = current_user.events.sum('outcome')
    @total              = @total_income_all - @total_outcome_all
    @residue            = @total - @total_saving_all
    m                   = params['month'] || Time.now.month
    y                   = params['year'] || Time.now.year
    @total_income       = current_user.events.by_month(m,year:y).sum('income')
    @total_saving       = current_user.events.by_month(m,year:y).sum('savings')
    @total_expenses     = current_user.events.by_month(m,year:y).sum('outcome')
    @total_month        = @total_income - @total_expenses
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
    @event = Event.new
    @target_finish = TargetSaving.find(params[:id])
    @event = @event.finish @target_finish, current_user 
    respond_to do |format|
      if @event.save
        @target_finish.destroy
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
