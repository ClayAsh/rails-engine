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

  def self.top_merchants_by_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'}, invoices: {status: 'shipped'})
    .select(:name, :id, 'SUM(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .group(:id)
    .order(revenue: :desc)
    .limit(quantity)
  end

  def self.ranked_merchants(number)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'}, invoices: {status: 'shipped'})
    .select(:name, :id, 'SUM(invoice_items.quantity) as count')
    .group(:id)
    .order(count: :desc)
    .limit(number)
  end

end
