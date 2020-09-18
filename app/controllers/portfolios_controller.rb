class PortfoliosController < ApplicationController

    def index
        portfolios = @current_user.portfolios
        render json: portfolios, each_serializer: PortfolioSerializer
    end

    def show
        portfolio = Portfolio.find_by(user_id: @current_user.id, id: portfolio_params[:id])
        if portfolio.valid?
            render json: { portfolio: PortfolioSerializer.new(portfolio) }
        else
            render json: { error: 'Unable to find portfolio' }, status: :bad_request
        end

    end

    def create
        portfolio = @current_user.portfolios.create(portfolio_params)
        if portfolio.valid?
            render json: { portfolio: PortfolioSerializer.new(portfolio) }
        else
            render json: { error: 'Unable to create portfolio' }, status: :bad_request
        end
    end

    private

    def portfolio_params
        params.permit(:name, :id)
    end

end
