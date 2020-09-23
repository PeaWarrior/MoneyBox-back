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
