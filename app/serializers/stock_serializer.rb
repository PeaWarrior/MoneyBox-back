class StockSerializer < ActiveModel::Serializer
  attributes :id, :name, :ticker
  has_many :activities
end
