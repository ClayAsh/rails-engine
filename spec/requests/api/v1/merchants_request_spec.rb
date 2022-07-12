require 'rails_helper'

RSpec.describe "Merchants API" do 
  it 'can send all merchants' do 
    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to be_a(Array)
    require 'pry'; binding.pry
    # expect(merchants.count).to eq(100)

    merchants.each do |merch|
      expect(merch).to have_include(:id, :name)
      expect(merch.name).to be_a(String)
      expect(merch.id).to be_a(Integer)
    end
  end
end