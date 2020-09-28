class Fund < ApplicationRecord
  belongs_to :portfolio

  validates :date, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true, inclusion: { in: %w(Withdrawal Deposit) }
  
end
