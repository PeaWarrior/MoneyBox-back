class PortfolioSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :user
  has_many :transactions
end
