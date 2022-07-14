class Api::V1::ItemSearchController < ApplicationController

  def index 
    if params[:name] && (params[:min_price] || params[:max_price])
      render json: {data: {error: "You can only search by name OR price"}}, status: 400
    elsif params[:name].present? && params[:name] != "" 
      item = Item.name_search(params[:name])
      render json: ItemSerializer.new(item)

    elsif params[:name] == "" 
      render json: {data: {error: "Search Cannot be Empty"}}, status: 400

    elsif params[:min_price].present? && params[:min_price] != ""
      item = Item.min_price_search(params[:min_price].to_f)
      render json: ItemSerializer.new(item)

    elsif params[:min_price] == "" 
      render json: {data: {error: "Search Cannot be Empty"}}, status: 400

    elsif params[:max_price].present? && params[:max_price] != ""
      item = Item.max_price_search(params[:max_price].to_f)
      render json: ItemSerializer.new(item) 

    elsif params[:max_price] == "" 
      render json: {data: {error: "Search Cannot be Empty"}}, status: 400

    elsif params[:max_price].present? && params[:min_price].present? && (params[:max_price] != "" && params[:min_price] != "")
      item = Item.min_and_max_search(params[:min_price].to_f, params[:max_price].to_f)
      render json: ItemSerializer.new(item)

    elsif params[:max_price] == "" || params[:min_price] == ""
      render json: {data: {error: "Search Cannot be Empty"}}, status: 400
    end
  end
end
