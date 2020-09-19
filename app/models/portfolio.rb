class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :funds, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :activities, through: :stocks

  validates :name, presence: true

end
