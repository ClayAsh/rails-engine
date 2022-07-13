require 'rails_helper'

RSpec.describe Item, type: :model do 
  let!(:merch_1) { Merchant.create(name: "H-Mart") }
  let!(:item_1) { Item.create(name: "Turing", description: "learn the stuff", unit_price: 20.0, merchant_id: merch_1.id) }
  let!(:item_2) { Item.create(name: "Ring", description: "wear the thing", unit_price: 15.50, merchant_id: merch_1.id) }
  let!(:item_3) { Item.create(name: "Trampoline", description: "do the thing", unit_price: 5.50, merchant_id: merch_1.id) }

  it { should validate_presence_of(:name) } 
  it { should validate_presence_of(:description) } 
  it { should validate_presence_of(:unit_price) } 
  it { should validate_presence_of(:merchant_id) } 

  it { should have_many(:invoice_items) }
  it { should have_many(:invoices).through(:invoice_items) }
  it { should have_many(:transactions).through(:invoices) }
  it { should belong_to(:merchant) }
  it { should have_many(:customers).through(:invoices) }

  it 'can search for a merchant by name' do 
    expect(Item.name_search("ring")).to eq([item_1, item_2])
    # expect(Item.name_search("ring")).to_not include(item_3)
  end
end