class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :type, :price, :shares, :date
  has_one :portfolio
end
