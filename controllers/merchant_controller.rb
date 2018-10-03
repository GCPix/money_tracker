require("sinatra")
require("sinatra/contrib/all")
require("pry")
require_relative("../models/merchant")
require_relative("../models/transaction")

also_reload('..models/*')


get '/merchants' do
  @balance = Transaction.current_balance
  @merchants = Merchant.find_all
  @transaction = Transaction.find_all
  @merchant_list = Merchant.usage_frequency
  erb(:"merchants/index")
end
get '/merchants/new' do
@balance = Transaction.current_balance
  erb(:"merchants/new")
end
get '/merchants/:id' do
  @balance = Transaction.current_balance
  @merchant = Merchant.find(params[:id])
  erb(:"merchants/show_merchant")
end
get '/merchants/:id/edit' do
  @balance = Transaction.current_balance
  @merchant = Merchant.find(params[:id])
  erb(:"merchants/edit")
end
get '/merchants/:id/transactions' do
  @balance = Transaction.current_balance
  @merchant_list = Merchant.find_all
  @transaction_list = Merchant.all_transactions(params[:id])
  @transaction_list.each{|t| t.t_date = t.t_date.strftime("%d/%m/%y")}
  erb(:"merchants/merchant_transactions")
end


post '/merchants' do
  @balance = Transaction.current_balance
  @merchant_list = Merchant.find_all
  for merchant in @merchant_list
    if params[:name].capitalize==merchant.name
      redirect "/merchants"
    end
  end
  @merchant = Merchant.new(params)
  @merchant.save
  redirect "/merchants"
end

post '/merchants/delete/:id' do
  merchant = Merchant.find(params[:id])

  merchant.delete_one
  redirect "/merchants"
end

post '/merchants/:id' do
  @merchant = Merchant.new(params)
  @merchant.edit()
  redirect "/merchants"
end
