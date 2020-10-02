class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :funds, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :activities, through: :stocks

  validates :name, presence: true

  def cash
    total = 0
    total += totalFunds.to_f
    total += realized.to_f
    total -= costBasis().to_f
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

    deposits.each do |deposit|
      total += deposit.amount
    end

    withdrawals.each do |withdraw|
      total -= withdraw.amount
    end

    '%.2f' % total
  end

  private

  def pricePerShare(activity)
    activity.price/activity.shares
  end

  def deposits
    funds.filter{ |fund| fund.category === 'Deposit' }
  end

  def withdrawals
    funds.filter{ |fund| fund.category === 'Withdrawal' }
  end

end
