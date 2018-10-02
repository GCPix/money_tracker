require("sinatra")
require("sinatra/contrib/all")
require("pry")
require_relative("../models/tag")
require_relative("../models/merchant")
require_relative("../models/transaction")

also_reload('..models/*')

get '/transactions' do
  @balance = Transaction.current_balance
  @transaction_list = Transaction.find_all
  @transaction_list.each{|t| t.t_date = t.t_date.strftime("%d/%m/%y")}
  @outgoing = Transaction.outgoings_total
  @merchant_list = Merchant.find_all
  @tag_list = Tag.find_all
  erb(:"transactions/index")
end

get '/transactions/date_pick' do
  @balance = Transaction.current_balance
  erb(:"transactions/date_pick")
end

post '/transactions/date' do
  @balance = Transaction.current_balance
  @transaction_list = Transaction.find_transaction_by_date(params[:first_date], params[:second_date])
  @transaction_list.each{|t| t.t_date = t.t_date.strftime("%d/%m/%y")}
  @merchant_list = Merchant.find_all
  @tag_list = Tag.find_all
  erb(:"transactions/transaction_date")
end

get '/transactions/new' do
  @balance = Transaction.current_balance
  @merchant_list = Merchant.find_all
  @tag_list = Tag.find_all
  erb(:"transactions/new")
end

get '/transactions/:id/edit' do
  @balance = Transaction.current_balance
  @merchant_list = Merchant.find_all
  @tag_list = Tag.find_all
  @transaction = Transaction.find_transaction_by_id(params[:id])
  erb(:"transactions/edit")
end


post '/transactions' do
  @transaction = Transaction.new(params)
  @transaction.save
  redirect "/transactions"
end

post '/transactions/:id' do
  @transaction = Transaction.new(params)
  @transaction.edit
  redirect "/transactions"
end

post '/transactions/delete/:id' do
  transaction = Transaction.find_transaction_by_id(params[:id])

  transaction.delete_one
  redirect "/transactions"
end
