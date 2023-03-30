class WorkshopsController < ApplicationController
  def show
    @workshop = Workshop.find(params[:id])
    authorize @workshop
  end 
 
  def new
    @workshop = Workshop.new
    authorize @workshop
  end

  def create
    @workshop = Workshop.new(workshop_params)
    authorize @workshop

    if @workshop.save
      redirect_to talleres_path
    else
      render "new", status: :unprocessable_entity
    end
  end

  private

  def workshop_params
    params.require(:workshop).permit(:name, :description, :date, :time, :photo)
  end
end
