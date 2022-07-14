class Api::V1::MerchantSearchController < ApplicationController
  def show 
    if params[:name] != ""
      merchant = Merchant.name_search(params[:name])
      render json: MerchantSerializer.new(merchant) if merchant
      render json: {data: {error: "Merchant not found"}}, status: 400 if !merchant
    else params[:name] == ""
      render json: {data: {error: "Search can not be empty"}}, status: 400
    end
  end
end