class Merchant < ApplicationRecord
  has_many :items#, dependent: :destroy  
  has_many :invoice_items, through: :items 
  has_many :invoices 
  has_many :transactions, through: :invoices 
  has_many :customers, through: :invoices 

  def self.name_search(search) 
    where('lower(name) like ?', "%#{search.downcase}%")
    .order('name')
    .first
  end
end
