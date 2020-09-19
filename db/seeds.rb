User.destroy_all
Stock.destroy_all

user1 = User.create(username: 'jax', password: '123', password_confirmation: '123')

portfolio = user1.portfolios.create(name: 'ROTH IRA')

portfolio.funds.create(name: "initial", amount: 1000)

stock1 = portfolio.stocks.create(name: 'Apple', ticker: 'AAPL')
stock2 = portfolio.stocks.create(name: 'Microsoft', ticker: 'MSFT')
stock3 = portfolio.stocks.create(name: 'Tesla', ticker: 'TSLA')

stock1.activities.create(category: 'buy', price: 500, shares: 100, date: Date.today)
stock2.activities.create(category: 'buy', price: 200, shares: 100, date: Date.today)
stock2.activities.create(category: 'buy', price: 200, shares: 100, date: Date.today)
stock3.activities.create(category: 'buy', price: 100, shares: 100, date: Date.today)
stock3.activities.create(category: 'sell', price: 50, shares: 20, date: Date.today)