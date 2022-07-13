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

  it 'can create an item' do 
    merchant = create(:merchant)
    item_params = { name: "The Thing", description: "It does the stuff", unit_price: 5.99 , merchant_id: merchant.id }
    headers = {'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

    item = Item.last 

    expect(response).to be_successful 
    expect(response.status).to eq(201)
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq(item_params[:unit_price])
    expect(item.merchant_id).to eq(item_params[:merchant_id])
  end

  it 'can update an item' do 
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    updated_item_params = { name: "The Thing", description: "It does the stuff", unit_price: 5.99 , merchant_id: merchant.id }
    headers = {'CONTENT_TYPE' => 'application/json'}

    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: updated_item_params)

    changed_item = Item.last 

    expect(response).to be_successful
    expect(item.name).to_not eq(changed_item.name)
    expect(item.description).to_not eq(changed_item.description)
    expect(item.unit_price).to_not eq(changed_item.unit_price)
  end

  it 'can delete an item' do 
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful 
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  xit 'can get merchant data for an item' do 
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

  end
end