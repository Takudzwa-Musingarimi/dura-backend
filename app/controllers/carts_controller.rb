class CartsController < ApplicationController
    def show
      cart = Cart.find(params[:id])
      render json: cart, include: { cart_items: { include: :product } }
    end

  end