require('sinatra')
require('sinatra/contrib/all')
require('sinatra/flash')
require_relative('controllers/merchant_controller')
require_relative('controllers/tag_controller')
require_relative('controllers/transaction_controller')


also_reload('..models/*')
enable :sessions


get '/' do

  flash[:warning] = "Hooray, Flash is working!"
  @balance = Transaction.current_balance
  @income = Transaction.income_last_30_days
  @outgoing = Transaction.outgoings_last_30_days

  erb(:index)
end
