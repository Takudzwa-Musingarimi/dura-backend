class PurchaseHistoriesController < ApplicationController
  before_action :authenticate_request
  before_action :find_user

  # GET /purchase_histories
  def index
    purchase_histories = @user.purchase_histories
    render json: purchase_histories, include: :product
  end

  private

  def authenticate_request
    token = request.headers['Authorization'].split(' ')[1]
    unless token && JsonWebToken.decode(token)
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  rescue JWT::DecodeError
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def find_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end
end
