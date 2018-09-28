require_relative("../models/transaction")
require_relative("../models/merchant")
require_relative("../models/tag")
require("pry-byebug")

merchant1 = Merchant.new("name" =>"Amazon")
merchant1.save()
merchant2 = Merchant.new("name" =>"Morrisons")
merchant2.save()
merchant3 = Merchant.new("name" =>"British Gas")
merchant3.save()
merchant4 = Merchant.new("name" =>"Waterstones")
merchant4.save()

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

transaction1 = Transaction.new("description" => "a book", "amount" => 1099, "date" => , "type" => "purchase", "merchant_id" => 4, "tag_id" => 6)
transaction1.save()

binding.pry
nil
