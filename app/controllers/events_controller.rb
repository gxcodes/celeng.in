class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def create
    @event = Event.add params, current_user
    respond_to do |format|
      if @event.save
        format.html { redirect_to dashboard_index_path, notice: 'successfully' }
      else
        format.html { render action: "new" }
      end
    end
  end
end
