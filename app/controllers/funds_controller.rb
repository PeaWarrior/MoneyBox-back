class FundsController < ApplicationController

    def deposit
        portfolio = @current_user.portfolios.find(fund_params[:portfolio_id])

        if portfolio
            fund = fund.create(fund_params)

            render json:  FundSerializer.new(fund)
        else
            render json: { error: 'Invalid request' }
        end
    end

    def withdraw
        portfolio = @current_user.portfolios.find(fund_params[:portfolio_id])

        if portfolio && portfolio.cash >= fund_params[:amount]
            fund = fund.create(fund_params)

            render json:  FundSerializer.new(fund)
        else
            render json: { error: 'Invalid request' }
        end
    end

    private
    def fund_params
        params.permit(:portfolio_id, :category, :amount)
    end
end
