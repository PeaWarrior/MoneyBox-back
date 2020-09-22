class Stock < ApplicationRecord
    belongs_to :portfolio
    has_many :activities, dependent: :destroy

    def self.fetchStockData(query)
        data = JSON.parse(RestClient.get('https://api.tdameritrade.com/v1/instruments', {
            params: {
                apikey: "#{ENV["TD_AMERITRADE_API_KEY"]}",
                symbol: query,
                projection: 'fundamental'
            }
        }))[query.upcase]
        data_params = {
            name: data['description'].split(' - ')[0],
            ticker: data['symbol'],
            fundamental: {
                high52: data['fundamental']['high52'],
                low52: data['fundamental']['low52'],
                peRatio: data['fundamental']['peRatio'],
                vol1DayAverage: data['fundamental']['vol1DayAvg'],
                marketCap: data['fundamental']['marketCap']
            },
            dividend: {
                AmountPerYear: data['fundamental']['dividendAmount'],
                ExDivDate: data['fundamental']['dividendDate'],
                PayAmount: data['fundamental']['dividendPayAmount'],
                PayDate: data['fundamental']['dividendPayDate']
            }
        }
    end

    def self.fetchStockNewsData(query)
        data = JSON.parse(RestClient.get('https://finnhub.io/api/v1/company-news', {
            params: {
                token: "#{ENV["FINNHUB_API_KEY"]}",
                symbol: query,
                from: Date.today.strftime("%Y-%m-%d"),
                to: Date.today.strftime("%Y-%m-%d")
            }
        }))
    end

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
