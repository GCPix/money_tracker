require("sinatra")
require("sinatra/contrib/all")
require("pry")
require_relative("../models/tag")
require_relative("../models/transaction")

also_reload('..models/*')


get '/tags' do
  @tags = Tag.find_all
  @tag_list = Tag.usage_frequency
  erb(:"tags/index")
end
get '/tags/new' do

  erb(:"tags/new")
end
get '/tags/:id' do
  @tag = Tag.find(params[:id])
  erb(:"tags/show_tag")
end
get '/tags/:id/edit' do
  @tag = Tag.find(params[:id])
  erb(:"tags/edit")
end
get '/tags/:id/transactions' do
  @transaction_list = Tag.all_transactions(params[:id])
  erb(:"tags/tag_transactions")
end


post '/tags' do
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
