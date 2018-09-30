require("sinatra")
require("sinatra/contrib/all")
require("pry")
require_relative("../models/merchant")
require_relative("../models/transaction")

also_reload('..models/*')


get '/merchants' do
  @merchants = Merchant.find_all
  @merchant_list = Merchant.usage_frequency
  erb(:"merchants/index")
end
get '/merchants/new' do

  erb(:"merchants/new")
end
get '/merchants/:id' do
  @merchant = Merchant.find(params[:id])
  erb(:"merchants/show_merchant")
end
get '/merchants/:id/edit' do
  @merchant = Merchant.find(params[:id])
  erb(:"merchants/edit")
end
get '/merchants/:id/transactions' do
  @transaction_list = Merchant.all_transactions(params[:id])
  erb(:"merchants/merchant_transactions")
end


post '/merchants' do
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
