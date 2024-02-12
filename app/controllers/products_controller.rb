class ProductsController < ApplicationController
  before_action :authenticate_request, only: [:create]

  # GET /products
  def index
    @products = Product.all
    render json: @products
  end

  # POST /products
  def create
    # Find an existing product by name
    @product = Product.find_by(name: product_params[:name])

    if @product.nil?
      # If the product doesn't exist, create a new one
      @product = Product.new(product_params)
    else
      # If the product exists, update its attributes
      @product.update(product_params)
    end
    
    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end
  
  private
  
  def product_params
    params.require(:product).permit(:name, :english_name, :description, :price, :measurement_unit, :total_units, :image_url)
  end

  def authenticate_request
    token = request.headers['Authorization'].split(' ')[1]
    unless token && JsonWebToken.decode(token)
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  rescue JWT::DecodeError
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
