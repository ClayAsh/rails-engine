class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  has_many :invoice_items
  has_many :invoices, through: :invoice_items 
  has_many :transactions, through: :invoices
  belongs_to :merchant
  has_many :customers, through: :invoices

  def self.name_search(search) 
    where('lower(name) like ?', "%#{search.downcase}%")
  end
end
