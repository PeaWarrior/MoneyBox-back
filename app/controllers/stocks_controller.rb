class StocksController < ApplicationController

    def show
        stockData = Stock.fetchStockData(params[:id])
        stockNewsData = Stock.fetchStockNewsData(params[:id])
        stockData[:news] = stockNewsData
        render json: stockData
    end

    def quotes
        stockData = Stock.fetchStockQuotes(params[:queries])
        render json: stockData
    end
    
    def intraday
        openPrice = request.headers[:openPrice]
        intradayData = Stock.fetchIntradayPrices(params[:ticker], openPrice)
        render json: intradayData
    end

end
