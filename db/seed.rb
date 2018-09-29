require_relative("../models/transaction")
require_relative("../models/merchant")
require_relative("../models/tag")
require("pry-byebug")

Transaction.delete_all
Merchant.delete_all
Tag.delete_all


merchant1 = Merchant.new("name" =>"Amazon")
merchant1.save()
merchant2 = Merchant.new("name" =>"Morrisons")
merchant2.save()
merchant3 = Merchant.new("name" =>"British Gas")
merchant3.save()
merchant4 = Merchant.new("name" =>"Waterstones")
merchant4.save()
merchant5  =Merchant.new("name" => "Gillian")
merchant5.save()

tag1 = Tag.new("name" =>"Food")
tag1.save()
tag2 = Tag.new("name" =>"eating out")
tag2.save()
tag3 = Tag.new("name" =>"cat costs")
tag3.save()
tag4 = Tag.new("name" =>"clothes")
tag4.save
tag5 = Tag.new("name" =>"electricity")
tag5.save()
tag6 = Tag.new("name" =>"other")
tag6.save()
tag7 = Tag.new("name" => "paid in")
tag7.save()

transaction1 = Transaction.new("description" => "a book", "amount" => 1099, "t_date" => "2018-05-06" , "type" => "purchase", "merchant_id" => merchant1.id, "tag_id" => tag6.id)
transaction1.save()
transaction2 = Transaction.new("description" => "catsan", "amount" => 1095, "t_date" => "2018-09-20" , "type" => "purchase", "merchant_id" => merchant2.id, "tag_id" => tag3.id)
transaction2.save()
transaction3 = Transaction.new("description" => "lunch", "amount" => 495, "t_date" => "2018-09-26" , "type" => "purchase", "merchant_id" => merchant2.id, "tag_id" => tag2.id)
transaction3.save()
transaction4 = Transaction.new("description" => "salary", "amount" => 100000, "t_date" => "2018-08-04" , "type" => "pay in", "merchant_id" => merchant5.id, "tag_id" => tag7.id)
transaction4.save()
transaction5 = Transaction.new("description" => "salary", "amount" => 100000, "t_date" => "2018-09-20" , "type" => "pay in", "merchant_id" => merchant5.id, "tag_id" => tag7.id)
transaction5.save()



binding.pry
nil
