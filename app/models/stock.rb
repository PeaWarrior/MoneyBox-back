class Stock < ApplicationRecord
    belongs_to :portfolio
    has_many :activities, dependent: :destroy

    def costBasis
        unsold_buys().sum{|unsold_buy| unsold_buy.average_price * unsold_buy.remaining}
    end

    def average_price
        shares() > 0 ? costBasis()/shares() : 0
    end

    def shares
        unsold_buys().sum{|unsold_buy| unsold_buy.remaining }
    end

    def realized
        totalSellPrice = sells.sum{|sell| sell.price }
        soldCostBasis = sold_buys().sum{|sold_buy| 
            sold_buy.average_price * (sold_buy.shares - sold_buy.remaining)
        }
        totalSellPrice - soldCostBasis
    end

    private
    def unsold_buys
        unsold_buys = activities.select { |activity| 
            activity.category == 'buy' && activity.remaining > 0
        }
    end

    def sold_buys
        sold_buys = activities.select { |activity|
            activity.category == 'buy' && activity.remaining != activity.shares
        }
    end

    def sells
        activities.select {|activity| activity.category == 'sell'}
    end

end
