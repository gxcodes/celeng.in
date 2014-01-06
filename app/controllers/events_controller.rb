class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def create
    @event = Event.add params, current_user
    respond_to do |format|
      if Event.check_balance(@event)
        if @event.save
          format.html { redirect_to dashboard_index_path, notice: 'successfully' }
        else
          format.html { render action: "new" }
        end
      else
        format.html { redirect_to dashboard_index_path, notice: 'Overload' }
      end
    end
  end
end
