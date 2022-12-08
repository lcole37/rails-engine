class Api::V1::MerchantItemsController < ApplicationController
  def index
    # if Merchant.exists?(params[:merchant_id])
      merchant = Merchant.find(params[:merchant_id])
      items = merchant.items
      render json: ItemSerializer.new(items)
    # else
    #   render json: {error: "error; not found"}, status: 404
    # end
  end
end
