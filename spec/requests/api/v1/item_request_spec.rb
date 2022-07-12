require 'rails_helper'

RSpec.describe "Item api" do 
  it 'can get all items' do 
    merchant = create(:merchant)
    create_list(:item, 5, merchant_id: merchant.id)

    get '/api/v1/items'

    all_items = JSON.parse(response.body, symbolize_names: true)
    items = all_items[:data]
    
    expect(response).to be_successful
    expect(all_items).to be_a(Hash)
    expect(items[0][:attributes][:name]).to eq(Item.first.name)
    expect(items.count).to eq(5)
    items.each do |item|
      expect(item[:attributes]).to include(:name, :description, :unit_price, :merchant_id)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to eq(merchant.id)
    end
  end

  it 'can get one item' do 
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}"

    all_item = JSON.parse(response.body, symbolize_names: true)
    item = all_item[:data]

    expect(response).to be_successful
    expect(item).to include(:id)
    expect(item[:attributes]).to include(:name, :description, :unit_price, :merchant_id)
    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes][:merchant_id]).to eq(merchant.id)
  end
end