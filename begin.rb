require('sinatra')
require('sinatra/contrib/all')
require('sinatra/flash')
require_relative('controllers/merchant_controller')
require_relative('controllers/tag_controller')
require_relative('controllers/transaction_controller')


also_reload('./models/*')



get '/' do
  @balance = Transaction.current_balance
  @income = Transaction.income_last_30_days
  @outgoing = Transaction.outgoings_last_30_days

  erb(:index)
end
