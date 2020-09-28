class FundSerializer < ActiveModel::Serializer
  attributes :id, :category, :amount, :date
end
