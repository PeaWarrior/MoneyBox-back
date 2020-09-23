class Activity < ApplicationRecord
  # has_one :activity_stock, dependent: :destroy
  # has_one :stock, through: :activity_stock

  belongs_to :stock

  validates :category, presence: true, inclusion: { in: %w(Dividend Buy Sell) }
  validates :price, presence: true
  validates :date, presence: true
  validates :shares, presence: true, unless: [:category_is_fund? || :category_is_dividend?]

  def average_price
    price/shares
  end

  private

  def category_is_fund?
    self.category === 'Fund' ? true : false
  end

  def category_is_dividend?
    self.category === 'Dividend' ? true : false
  end

end
