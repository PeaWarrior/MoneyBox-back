class Activity < ApplicationRecord
  belongs_to :stock

  validates :category, presence: true, inclusion: { in: %w(Dividend Buy Sell) }
  validates :price, presence: true
  validates :date, presence: true
  validates :shares, presence: true
  validates :shares, numericality: { greater_than: 0 }, unless: [:category_is_dividend?]

  private

  def category_is_dividend?
    self.category === 'Dividend' ? true : false
  end

end
