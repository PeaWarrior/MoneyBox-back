class FundsController < ApplicationController

    def deposit
        portfolio = @current_user.portfolios.find(fund_params[:portfolio_id])

        if portfolio
            fund = Fund.create(fund_params)

            render json: { portfolio: PortfolioSerializer.new(portfolio)}
        else
            render json: { error: 'Invalid request' }
        end
    end

    def withdraw
        portfolio = @current_user.portfolios.find(fund_params[:portfolio_id])

        if portfolio && portfolio.cash >= fund_params[:amount]
            fund = Fund.create(fund_params)

            render json: { portfolio: PortfolioSerializer.new(portfolio)}
        else
            render json: { error: 'Invalid request' }
        end
    end

    private
    def fund_params
        params.permit(:portfolio_id, :category, :amount, :date)
    end
end
