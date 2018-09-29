require("sinatra")
require("sinatra/contrib/all")
require("pry")
require_relative("../models/merchant.rb")
also_reload('..models/*')


get '/merchants' do
  @merchants = Merchant.find_all
  @merchant_list = Merchant.usage_frequency
  erb(:"merchants/index")
end

get '/merchants/:id' do
  @merchant = Merchant.find(params[:id])
  erb(:"merchants/show_merchant")
end
