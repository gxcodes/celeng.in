class EventsController < ApplicationController

  def index
    target_saving = TargetSaving.find_by_id params[:saving_id]  
    @events = target_saving.events
    @target_saving      = TargetSaving.new
    @target_savings     = current_user.target_savings.joins('LEFT JOIN events ON target_savings.id = events.target_saving_id').group('target_savings.name').select("target_savings.* , sum(events.savings) as jumlah")
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
    @event = Event.new
  end

  def create
    @event = Event.add params, current_user
    respond_to do |format|
      if params[:transaksi] == "add_outcome" || params[:transaksi] == "add_income"
        if @event.save
          format.html { redirect_to dashboard_index_path, notice: 'Transaction added successfully!' }
        else
          format.html { render action: "new" }
        end
      elsif Event.check_balance(@event)
        if @event.save
          format.html { redirect_to dashboard_index_path, notice: 'Savings added successfully!' }
        else
          format.html { render action: "new" }
        end
      else
        format.html { redirect_to dashboard_index_path, alert: 'Amount error. You can not add more than the amount left to reach the target savings.' }
      end
    end
  end
end
