class Api::V1::Merchants::MerchantsController < ApplicationController

  def index 
    merchants = Merchant.ranked_merchants(params[:quantity])
    render json: ItemsSoldSerializer.new(merchants)
  end
end 