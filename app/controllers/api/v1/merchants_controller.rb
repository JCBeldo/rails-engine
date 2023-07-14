class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def search
    if !params[:name].nil? && response.sent? == false
      render json: MerchantSerializer.new(Merchant.search(params[:name]))
    else
      render :status => 404
    end
  end
end
