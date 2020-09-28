User.destroy_all

user1 = User.create(username: 'jax', password: '123', password_confirmation: '123')

portfolio = user1.portfolios.create(name: 'ROTH IRA')
portfolio1 = user1.portfolios.create(name: 'ROBINHOOD')

portfolio.funds.create(category: 'Deposit', amount: 1000, date: Date.today)
portfolio.funds.create(category: 'Deposit', amount: 1000, date: Date.today)
portfolio.funds.create(category: 'Withdrawal', amount: 500, date: Date.today)