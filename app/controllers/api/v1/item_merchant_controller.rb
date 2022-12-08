class Api::V1::ItemMerchantController < ApplicationController
  def show
    merchant = item.merchant
    render json: MerchantSerializer.new(merchant)
  end

  def item
    Item.find(params[:item_id])
  end
end
