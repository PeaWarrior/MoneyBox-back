class StockSerializer < ActiveModel::Serializer
  attributes :id, :name, :ticker, :shares, :average_price, :realized, :costBasis
  has_many :activities
end
