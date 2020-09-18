class ActivityStock < ApplicationRecord
  belongs_to :activity
  belongs_to :stock
end
