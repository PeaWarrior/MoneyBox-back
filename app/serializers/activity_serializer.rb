class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :category, :price, :shares, :date
  has_one :portfolio
  has_one :stock
end
