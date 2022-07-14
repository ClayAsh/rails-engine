require 'rails_helper'

RSpec.describe 'item merchant api' do 
  it 'can get merchant data for an item' do 
    merchant_id = create(:merchant).id
    item = create(:item, merchant_id: merchant_id)

    get "/api/v1/items/#{item.id}/merchant"
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant).to be_a(Hash)

    merch = merchant[:data]
    expect(merch).to include(:id)
    expect(merch[:attributes]).to include(:name)
    expect(merch[:attributes][:name]).to be_a(String)
    expect(merch[:id]).to be_a(String)
    expect(merch[:id].to_i).to eq(item.merchant_id)
  end
end 