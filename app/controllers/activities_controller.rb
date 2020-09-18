class ActivitiesController < ApplicationController

    def create
        portfolio = @current_user.portfolios.find(activity_params[:portfolio_id])
        
        if portfolio
                activity = portfolio.activitys.create(activity_params)
            if activity.valid?
                render json: { activity: ActivitySerializer.new(activity) }
            end
        else
            render json: { error: 'Portfolio does not exist' }, status: :bad_request
        end
    
    end

    private

    def activity_params
        params.permit(:portfolio_id, :category, :price, :shares, :date)
    end
end
