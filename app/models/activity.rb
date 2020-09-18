class Activity < ApplicationRecord
  belongs_to :portfolio
  has_one :activity_stock, dependent: :destroy
  has_one :stock, through: :activity_stock

  validates :category, presence: true, inclusion: { in: %w(fund dividend buy sell) }
  validates :price, presence: true
  validates :date, presence: true
  validates :shares, presence: true, unless: [:category_is_fund? || :category_is_dividend?]

  private

  def category_is_fund?
    self.category === 'fund' ? true : false
  end

  def category_is_dividend?
    self.category === 'dividend' ? true : false
  end

end
