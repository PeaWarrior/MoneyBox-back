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
        intradayData = Stock.fetchIntradayPrices(params[:ticker])
        render json: intradayData
    end

end
