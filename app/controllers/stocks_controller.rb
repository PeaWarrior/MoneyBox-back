class StocksController < ApplicationController

    def show
        stockData = Stock.fetchStockData(params[:id])
        stockNewsData = Stock.fetchStockNewsData(params[:id])
        stockData[:news] = stockNewsData
        render json: stockData
    end

end
