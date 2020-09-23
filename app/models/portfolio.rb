class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :funds, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :activities, through: :stocks

  validates :name, presence: true

  def cash
    total = 0
    total += totalFunds.to_i
    total += realized.to_i
    total -= costBasis().to_i
    '%.2f' % total
  end

  def costBasis
    '%.2f' % stocks.sum{|stock| stock.costBasis()}
  end

  def realized
    '%.2f' % stocks.sum{|stock| stock.realized()}
  end

  def totalFunds
    total = 0

    funds.each do |fund|
      total += fund.amount
    end

    '%.2f' % total
  end

  private

  def pricePerShare(activity)
    activity.price/activity.shares
  end

end
