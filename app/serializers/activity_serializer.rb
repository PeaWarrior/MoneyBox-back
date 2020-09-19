class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :category, :price, :shares, :date
end