class FundSerializer < ActiveModel::Serializer
  attributes :id, :name, :amount
  has_one :portfolio
end
