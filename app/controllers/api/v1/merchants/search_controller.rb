class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = Merchant.find_merchant(params[:name])
    if merchant.nil?
      render json: { data: {message: 'Merchant not found'}}
    else
      render json: MerchantSerializer.new(merchant)
    end
  end
end
