class PortfoliosController < ApplicationController

    def index
        portfolios = @current_user.portfolios
        render json: { portfolios: portfolios }
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
        params.permit(:name)
    end

end
