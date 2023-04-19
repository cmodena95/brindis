class BillboardsController < ApplicationController
  def new
    @billboard = Billboard.new
    authorize @billboard

    @billboards = policy_scope(Billboard)
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

  def destroy
    @billboard = Billboard.find(params[:id])
    authorize @billboard

    if @billboard.destroy
      redirect_to new_billboard_path
    else
      render :new
    end
  end

  private

  def billboard_params
    params.require(:billboard).permit(:text)
  end
end
