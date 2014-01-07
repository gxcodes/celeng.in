class EventsController < ApplicationController

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
