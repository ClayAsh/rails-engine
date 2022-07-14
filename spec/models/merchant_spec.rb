require 'rails_helper'

RSpec.describe Merchant, type: :model do 
  let!(:merch_1) { Merchant.create(name: "H-Mart") }
  let!(:merch_2) { Merchant.create(name: "Smart") }

  it { should have_many(:items) }
  it { should have_many(:invoice_items).through(:items) }
  it { should have_many(:invoices) }
  it { should have_many(:transactions).through(:invoices) }
  it { should have_many(:customers).through(:invoices) }

  it 'can search for a merchant by name' do 
    expect(Merchant.name_search("mart")).to eq(merch_1)
  end
end 