class Api::V1::ItemMerchantController < ApplicationController
  def index
    item = Item.find(params[:item_id])
    if item.nil?
      render :status => 404
    else
      render json: MerchantSerializer.new(item.merchant)
    end
  end
end
