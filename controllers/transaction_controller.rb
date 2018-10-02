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
  @merchant_list = Merchant.find_all
  @tag_list = Tag.find_all
  erb(:"transactions/index")
end
get '/transactions/out' do
  @balance = Transaction.current_balance
  @transaction_list = Transaction.find_outgoing_all
  @transaction_list.each{|t| t.t_date = t.t_date.strftime("%d/%m/%y")}
  @outgoing = Transaction.outgoings_total
  @merchant_list = Merchant.find_all
  @tag_list = Tag.find_all
  erb(:"transactions/transaction_Pay_out")
end
get '/transactions/in' do
  @balance = Transaction.current_balance
  @transaction_list = Transaction.find_income_all
  @transaction_list.each{|t| t.t_date = t.t_date.strftime("%d/%m/%y")}
  @incoming = Transaction.income_total
  @merchant_list = Merchant.find_all
  @tag_list = Tag.find_all
  erb(:"transactions/transaction_Pay_in")
end

get '/transactions/date_pick' do
  @balance = Transaction.current_balance
  erb(:"transactions/date_pick")
end

post '/transactions/date' do
  @balance = Transaction.current_balance
  @transaction_list = Transaction.find_transaction_by_date(params[:first_date], params[:second_date])
  @transaction_list.each{|t| t.t_date = t.t_date.strftime("%d/%m/%y")}
  amount_array = @transaction_list.map{|transaction| transaction.amount}
  @balance = (amount_array.sum)
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
  if params[:type]=='Pay in'
    params[:amount]=(params[:amount].to_i)*100
  else
    params[:amount]=(params[:amount].to_i)*-100
  end

  @transaction = Transaction.new(params)
  @transaction.edit
  redirect "/transactions"
end

post '/transactions/delete/:id' do
  transaction = Transaction.find_transaction_by_id(params[:id])

  transaction.delete_one
  redirect "/transactions"
end
