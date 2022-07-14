require 'rails_helper'

RSpec.describe "Merchants API" do 
  it 'can send all merchants' do 
    create_list(:merchant, 10)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to be_a(Hash)
    expect(merchants[:data][0][:attributes][:name]).to eq(Merchant.first.name)
    expect(merchants[:data].count).to eq(10)

    merchants[:data].each do |merch|
      expect(merch).to include(:id)
      expect(merch[:attributes]).to include(:name)
      expect(merch[:attributes][:name]).to be_a(String)
      expect(merch[:id]).to be_a(String)
    end
  end

  it 'can return one merchant' do 
    id = create(:merchant).id 

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(merchant).to be_a(Hash)

    merch = merchant[:data]
    expect(merch).to include(:id)
    expect(merch[:attributes]).to include(:name)
    expect(merch[:attributes][:name]).to be_a(String)
    expect(merch[:id]).to be_a(String)
  end

  xit 'can sad path get one merchant' do 
    id = "banana"  

    get "/api/v1/merchants/#{id}"
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to be(404)
  end
end