class BillboardsController < ApplicationController
  def new
    @billboard = Billboard.new
    authorize @billboard
  end

  def create
    Billboard.destroy_all
    @billboard = Billboard.new(billboard_params)
    authorize @billboard

    if @billboard.save
      redirect_to root_path, notice: "Cambio exitoso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def billboard_params
    params.require(:billboard).permit(:text)
  end
end
