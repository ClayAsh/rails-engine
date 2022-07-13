require 'rails_helper'

RSpec.describe 'Item search api' do 
  let!(:merch_1) { Merchant.create(name: "H-Mart") }
  let!(:item_1) { Item.create(name: "Turing", description: "learn the stuff", unit_price: 20.0, merchant_id: merch_1.id) }
  let!(:item_2) { Item.create(name: "Ring", description: "wear the thing", unit_price: 15.50, merchant_id: merch_1.id) }
  let!(:item_3) { Item.create(name: "Trampoline", description: "do the thing", unit_price: 5.50, merchant_id: merch_1.id) }

  xit 'can find all items by name' do 

    get "/api/v1/items/find?name=ring"

    items_json = JSON.parse(response.body, symbolize_names: true)
    items = items_json[:data]

    expect(response).to be_successful
    expect(merchant).to be_a(Hash)

  end
end