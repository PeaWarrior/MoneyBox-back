class Stock < ApplicationRecord
    belongs_to :portfolio
    has_many :activities, dependent: :destroy

    def self.fetchStockData(query)
        data = JSON.parse(RestClient.get("https://api.tdameritrade.com/v1/marketdata/#{query.upcase}/quotes", {
            params: {
                apikey: "#{ENV["TD_AMERITRADE_API_KEY"]}"
            }
        }))[query.upcase]
        data_params = {
            name: data['description'].split(' - ')[0],
            ticker: data['symbol'],
            fundamental: {
                openPrice: ('%.2f' % data['openPrice']),
                closePrice: ('%.2f' % data['closePrice']),
                highPrice: ('%.2f' % data['highPrice']),
                lowPrice: ('%.2f' % data['lowPrice']),
                high52: ('%.2f' % data['52WkHigh']),
                low52: ('%.2f' % data['52WkLow']),
                peRatio: data['peRatio'],
                lastPrice: ('%.2f' % data['lastPrice'])
            },
            dividend: {
                amountPerYear: data['divAmount'],
                exDate: data['divDate'],
                yield: data['divYield'],
            }
        }
    end

    def self.fetchStockNewsData(query)
        data = JSON.parse(RestClient.get('https://finnhub.io/api/v1/company-news', {
            params: {
                token: "#{ENV["FINNHUB_API_KEY"]}",
                symbol: query,
                from: 2.days.ago.strftime("%Y-%m-%d"),
                to: Date.today.strftime("%Y-%m-%d")
            }
        }))
    end

    def self.fetchStockQuotes(queries)
        data = JSON.parse(RestClient.get("https://api.tdameritrade.com/v1/marketdata/quotes", {
            params: {
                apikey: "#{ENV["TD_AMERITRADE_API_KEY"]}",
                symbol: queries
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
