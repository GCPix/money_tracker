require("sinatra")
require("sinatra/contrib/all")
require("pry")
require_relative("../models/tag")
require_relative("../models/merchant")
require_relative("../models/transaction")

also_reload('..models/*')

get '/transactions' do
  @transaction_list = Transaction.find_all
  @merchant_list = Merchant.find_all
  @tag_list = Tag.find_all
  erb(:"transactions/index")
end

get '/transactions/new' do
  @merchant_list = Merchant.find_all
  @tag_list = Tag.find_all
  erb(:"transactions/new")
end

post '/transactions' do

  @transaction = Transaction.new(params)
  @transaction.save
  redirect "/transactions"
end
