class TransactionsController < ApplicationController

    def create
        portfolio = @current_user.portfolios.find(transaction_params[:portfolio_id])
        
        if portfolio
            transaction = portfolio.transactions.create(transaction_params)
            if transaction.valid?
                render json: { transaction: TransactionSerializer.new(transaction) }
            end
        else
            render json: { error: 'Portfolio does not exist' }, status: :bad_request
        end
    
    end

    private

    def transaction_params
        params.permit(:portfolio_id, :type, :price, :shares, :date)
    end
end
