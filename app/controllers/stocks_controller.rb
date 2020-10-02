class StocksController < ApplicationController

    def index
        stockSymbols = Stock.fetchStockSymbols
        render json: stockSymbols
    end

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

    def week
        weekData = Stock.fetchWeekPrices(params[:ticker])
        render json: weekData
    end

    def historical
        period = request.headers[:period]
        periodType = request.headers[:periodType]
        historicalData = Stock.fetchHistoricalPrices(params[:ticker], periodType, period)
        render json: historicalData
    end

end
