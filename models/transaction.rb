require_relative('../db/sql_runner')
require('date')

class Transaction

  attr_reader :id, :merchant_id, :tag_id
  attr_accessor :description, :amount, :t_date, :type

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @description = options["description"]
    @amount = options["amount"].to_i
    @t_date = options["t_date"]
    @type = options["type"]
    @merchant_id = options["merchant_id"].to_i
    @tag_id = options["tag_id"].to_i

  end

  def save
    sql = "INSERT INTO transactions(description, amount, t_date, type, merchant_id, tag_id) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id"
    values = [@description, @amount, @t_date, @type, @merchant_id, @tag_id]

    result = SqlRunner.run(sql, values)
    @id = result.first["id"].to_i
  end

end
