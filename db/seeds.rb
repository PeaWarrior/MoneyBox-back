User.destroy_all

user1 = User.create(username: 'jax', password: '123', password_confirmation: '123')

portfolio1 = user1.portfolios.create(name: 'ROTH IRA')

portfolio1.activities.create(category: 'fund', price: 1000, date: Date.today)