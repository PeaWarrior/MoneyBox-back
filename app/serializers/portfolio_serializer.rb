class PortfolioSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :cash, :currentPositions
  has_one :user
  has_many :stocks
  has_many :funds

end
