class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :category, :price, :shares, :date
  has_one :portfolio
end
