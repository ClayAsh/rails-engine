require 'rails_helper'

RSpec.describe 'Item search api' do 
  let!(:merch_1) { Merchant.create(name: "H-Mart") }
  let!(:item_1) { Item.create(name: "Turing", description: "learn the stuff", unit_price: 20.0, merchant_id: merch_1.id) }
  let!(:item_2) { Item.create(name: "Ring", description: "wear the thing", unit_price: 15.50, merchant_id: merch_1.id) }
  let!(:item_3) { Item.create(name: "Trampoline", description: "do the thing", unit_price: 5.50, merchant_id: merch_1.id) }

  it 'can search items by name' do 
    get "/api/v1/items/find_all?name=ring"

    items_json = JSON.parse(response.body, symbolize_names: true)
    items = items_json[:data]

    expect(response).to be_successful
    expect(items_json).to be_a(Hash)

    items.each do |item|
    expect(item).to include(:id)
    expect(item[:attributes]).to include(:name, :description, :unit_price, :merchant_id)
    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes][:merchant_id]).to eq(merch_1.id)
    end
  end

  it 'can search for item by name and get no matching item' do 
     get "/api/v1/items/find_all?name=hampster"

    items_json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(items_json[:data]).to eq([])
  end

  it 'can search for item by price and get no matching item' do 
     get "/api/v1/items/find_all?max_price=1"

    items_json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(items_json[:data]).to eq([])
  end

  it 'can send empty name params for name and get error message' do 
     get "/api/v1/items/find_all?name="

    items_json = JSON.parse(response.body, symbolize_names: true)
    items = items_json[:data]

    expect(response.status).to eq(400)
    expect(items[:error]).to eq("Search Cannot be Empty")
  end

  it 'can send empty price params for min price and get error message' do 
     get "/api/v1/items/find_all?min_price="

    items_json = JSON.parse(response.body, symbolize_names: true)
    items = items_json[:data]

    expect(response.status).to eq(400)
    expect(items[:error]).to eq("Search Cannot be Empty")
  end

  it 'can send empty price params for max price and get error message' do 
     get "/api/v1/items/find_all?max_price="

    items_json = JSON.parse(response.body, symbolize_names: true)
    items = items_json[:data]

    expect(response.status).to eq(400)
    expect(items[:error]).to eq("Search Cannot be Empty")
  end

  it 'can search items by min price' do 
    get "/api/v1/items/find_all?min_price=10"

    items_json = JSON.parse(response.body, symbolize_names: true)
    items = items_json[:data]

    expect(response).to be_successful
    expect(items_json).to be_a(Hash)

    items.each do |item|
    expect(item).to include(:id)
    expect(item[:attributes]).to include(:name, :description, :unit_price, :merchant_id)
    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes][:merchant_id]).to eq(merch_1.id)
    end
  end

  it 'can search items by max price' do 
    get "/api/v1/items/find_all?max_price=10"

    items_json = JSON.parse(response.body, symbolize_names: true)
    items = items_json[:data]

    expect(response).to be_successful
    expect(items_json).to be_a(Hash)

    items.each do |item|
    expect(item).to include(:id)
    expect(item[:attributes]).to include(:name, :description, :unit_price, :merchant_id)
    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes][:merchant_id]).to eq(merch_1.id)
    end
  end

  it 'can search items by min and max price' do 
    get "/api/v1/items/find_all?max_price=10&min_price=17"

    items_json = JSON.parse(response.body, symbolize_names: true)
    items = items_json[:data]

    expect(response).to be_successful
    expect(items_json).to be_a(Hash)

    items.each do |item|
    expect(item).to include(:id)
    expect(item[:attributes]).to include(:name, :description, :unit_price, :merchant_id)
    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes][:merchant_id]).to eq(merch_1.id)
    end
  end

  it 'can send empty min price params in min and max search for item and get error message' do 
     get "/api/v1/items/find_all?max_price=10&min_price="

    items_json = JSON.parse(response.body, symbolize_names: true)
    items = items_json[:data]

    expect(response.status).to eq(400)
    expect(items[:error]).to eq("Search Cannot be Empty")
  end

  it 'can send empty price params in min and max search for item and get error message' do 
    get "/api/v1/items/find_all?max_price=&min_price="

    items_json = JSON.parse(response.body, symbolize_names: true)
    items = items_json[:data]

    expect(response.status).to eq(400)
    expect(items[:error]).to eq("Search Cannot be Empty")
  end

  it 'can send in price and name params and get an error' do 
    get '/api/v1/items/find_all?name=ring&min_price=50'

    items_json = JSON.parse(response.body, symbolize_names: true)
    items = items_json[:data]

    expect(response.status).to eq(400)
    expect(items[:error]).to eq("You can only search by name OR price")
  end
end