class EventsController < ApplicationController
  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    authorize @event

    if @event.save
      redirect_to eventos_path
    else
      render "new", status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :start_time, :end_time, :poster)
  end
end
