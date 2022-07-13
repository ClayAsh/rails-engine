class ItemMerchantsController < ApplicationController
  def show 
    item = Item.find(params[:item_id])
    require 'pry'; binding.pry
    render json: MerchantSerializer.new(item.merchants)
  end
end