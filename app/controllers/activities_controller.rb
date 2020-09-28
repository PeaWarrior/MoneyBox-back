class ActivitiesController < ApplicationController

    def create
        portfolio = @current_user.portfolios.find(portfolio_params[:portfolio_id])
        
        if portfolio
                stock = portfolio.stocks.find_or_create_by(stock_params)
                activity = stock.activities.create(activity_params)
                activity.update(remaining: activity.shares) if activity.category === 'Buy'
            if activity.valid?
                render json: { activity: ActivitySerializer.new(activity) }
            end
        else
            render json: { error: 'Portfolio does not exist' }, status: :bad_request
        end
    end

    def sell
        portfolio = @current_user.portfolios.find(portfolio_params[:portfolio_id])

        if portfolio

            stock = portfolio.stocks.find_by(stock_params)
            sharesToSell = activity_params[:shares].to_i

            if stock.shares >= sharesToSell
                stock.sell(activity_params[:shares].to_i)
                stock.activities.create(activity_params)
                render json: { portfolio: PortfolioSerializer.new(portfolio) }, include: '**'
            else
                render json: { error: 'Invalid request' }
            end
        else
            render json: { error: 'Invalid request' }
        end
    end

    private

    def portfolio_params
        params.permit(:portfolio_id)
    end

    def stock_params
        params.permit(:name, :ticker)
    end

    def activity_params
        params.permit(:category, :price, :shares, :date)
    end

end
