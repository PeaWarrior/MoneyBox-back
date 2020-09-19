class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :funds, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :activities, through: :stocks

  validates :name, presence: true

  def cash
    total = 0
    total += totalFunds
    total += realized
    total -= costBasis()
    total
  end

  def costBasis
    stocks.sum{|stock| stock.costBasis()}
  end

  def realized
    stocks.sum{|stock| stock.realized()}
  end

  def totalFunds
    total = 0

    funds.each do |fund|
      total += fund.amount
    end

    total
  end

  private

  def pricePerShare(activity)
    activity.price/activity.shares
  end

end
