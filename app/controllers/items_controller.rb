class ItemsController < ApplicationController
  def new
    @item = Item.new
    authorize @item
  end

  def create
    @previous_item = Item.find_by(position: params[:item][:position])
    @previous_item.destroy if @previous_item
    @item = Item.new(item_params)
    authorize @item

    if @item.save
      redirect_to new_item_path, notice: "Cambio exitoso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:link, :position, :photo)
  end
end
