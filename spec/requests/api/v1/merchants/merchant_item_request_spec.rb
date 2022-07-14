require 'rails_helper'

RSpec.describe "Merchant Item api" do 
  it 'can return all items for a merchant' do 
    merchant = create(:merchant)
    create_list(:item, 5, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    merchant_items = JSON.parse(response.body, symbolize_names: true)
    items = merchant_items[:data]

    expect(response).to be_successful
    expect(items.count).to eq(5)

    items.each do |item|
      expect(item).to include(:id)
      expect(item[:type]).to eq("item")
      expect(item[:attributes]).to include(:name, :description, :unit_price)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to eq(merchant.id)
      expect(items[0][:attributes][:name]).to eq(Item.first.name)
    end
  end
end 