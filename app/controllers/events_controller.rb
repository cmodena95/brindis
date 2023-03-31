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
    @event = Event.find(params[:id])
    authorize @event
  end

  def edit
    @event = Event.find(params[:id])
    authorize @event
  end

  def update
    @event = Event.find(params[:id])
    authorize @event
    if @event.update(event_params)
      redirect_to eventos_path
    else
      render "edit", status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :start_time, :end_time, :poster, photos: [])
  end
end
