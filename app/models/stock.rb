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

    def self.fetchIntradayPrices(query)
        data = JSON.parse(RestClient.get("https://sandbox.iexapis.com/stable/stock/#{query}/intraday-prices", {
            params: {
                token: "#{ENV["IEX_SANDBOX_API_KEY"]}",
                chartIEXOnly: true
            }
        }))
        data.map do |intradayTrade|
            {
                date: intradayTrade['date'],
                label: intradayTrade['label'],
                minute: intradayTrade['minute'],
                average: intradayTrade['average'] ? ('%.2f' % intradayTrade['average']) : nil
            }
        end
    end

    def costBasis
        unsold_buys().sum{|unsold_buy| unsold_buy.price * unsold_buy.remaining}
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

    def unsold_buys
        unsold_buys = activities.select { |activity| 
            activity.category == 'Buy' && activity.remaining > 0
        }
    end

    def sell(sharesToSell)
        unsold_buys.each do |unsold_buy|
            if sharesToSell > 0
                if sharesToSell > unsold_buy.remaining
                    sharesToSell -= unsold_buy.remaining
                    unsold_buy.update(remaining: 0)
                else
                    unsold_buy.update(remaining: unsold_buy.remaining-sharesToSell)
                    sharesToSell = 0
                    return self
                end
            else
                return self
            end
        end
    end

    private

    def sold_buys
        sold_buys = activities.select { |activity|
            activity.category == 'Buy' && activity.remaining != activity.shares
        }
    end

    def sells
        activities.select {|activity| activity.category == 'Sell'}
    end

end
