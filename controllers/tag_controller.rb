require("sinatra")
require("sinatra/contrib/all")
require("pry")
require_relative("../models/tag")
require_relative("../models/transaction")

also_reload('..models/*')


get '/tags' do
  @balance = Transaction.current_balance
  @tags = Tag.find_all
  @tag_list = Tag.usage_frequency
  erb(:"tags/index")
end
get '/tags/new' do
@balance = Transaction.current_balance
  erb(:"tags/new")
end
get '/tags/:id' do
  @balance = Transaction.current_balance
  @tag = Tag.find(params[:id])
  erb(:"tags/show_tag")
end
get '/tags/:id/edit' do
  @balance = Transaction.current_balance
  @tag = Tag.find(params[:id])
  erb(:"tags/edit")
end
get '/tags/:id/transactions' do
  @balance = Transaction.current_balance
  @tag_list = Tag.find_all
  @transaction_list = Tag.all_transactions(params[:id])
  @transaction_list.each{|t| t.t_date = t.t_date.strftime("%d/%m/%y")}
  erb(:"tags/tag_transactions")
end


post '/tags' do
  @tag_list = Tag.find_all
  for tag in @tag_list
    if params[:name].capitalize==tag.name
      redirect "/tags"
    end
  end
  @tag = Tag.new(params)
  @tag.save
  redirect "/tags"
end

post '/tags/delete/:id' do
  tag = Tag.find(params[:id])

  tag.delete_one
  redirect "/tags"
end

post '/tags/:id' do
  @tag = Tag.new(params)
  @tag.edit()
  redirect "/tags"
end
