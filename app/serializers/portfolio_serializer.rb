class PortfolioSerializer < ActiveModel::Serializer
  attributes :id, :name, :cash, :costBasis, :realized, :totalFunds, :created_at
  has_many :stocks
  has_many :funds

end
