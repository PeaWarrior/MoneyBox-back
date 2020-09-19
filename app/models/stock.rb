class Stock < ApplicationRecord
    belongs_to :portfolio
    has_many :activities
end
