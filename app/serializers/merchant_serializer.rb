class MerchantSerializer
  include JSONAPI::Serializer
  attributes :name

  # has_many :items, include_nested_associations: true 
end
