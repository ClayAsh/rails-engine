require 'rails_helper'

RSpec.describe 'merchant request api' do 
  let!(:merch_1) { Merchant.create(name: "H-Mart") }
  let!(:merch_2) { Merchant.create(name: "Smart") }

  it 'can do case insensitive search for a merchant' do 

    get "/api/v1/merchants/find?name=mart"

    merchant = JSON.parse(response.body, symbolize_names: true)
    merch = merchant[:data]

    expect(response).to be_successful
    expect(merchant).to be_a(Hash)

    expect(merch).to include(:id)
    expect(merch[:attributes]).to include(:name)
    expect(merch[:attributes][:name]).to be_a(String)
    expect(merch[:attributes][:name]).to eq("H-Mart")
    expect(merch[:id]).to be_a(String)
  end

  it 'can return error message if no merchant is found' do 
    get "/api/v1/merchants/find?name=Target"

    merchant = JSON.parse(response.body, symbolize_names: true)
    merch = merchant[:data]

    expect(response.status).to eq(400)
    expect(merch[:error]).to eq("Merchant not found")
  end

  it 'can return error message if no merchant is entered' do 
    get "/api/v1/merchants/find?name="

    merchant = JSON.parse(response.body, symbolize_names: true)
    merch = merchant[:data]

    expect(response.status).to eq(400)
    expect(merch[:error]).to eq("Search can not be empty")
  end
end