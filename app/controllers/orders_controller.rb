class OrdersController < ApplicationController

  def index
    Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
      redirect_to order_path(@order)
    else
      @beer = @order.beer
      flash.now[:alert] = "Erreur lors de la création de la commande."
      render "beers/show", status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:quantity, :beer_id)
  end
end
