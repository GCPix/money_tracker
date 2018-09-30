require_relative('../db/sql_runner')
require('date')

class Transaction

  attr_reader :id, :merchant_id, :tag_id
  attr_accessor :description, :amount, :t_date, :type

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @description = options["description"]
    @amount = (options["amount"].to_i)
    @t_date = Date.parse(options["t_date"], "%y/%m/%d")
    @type = options["type"]
    @merchant_id = options["merchant_id"].to_i
    @tag_id = options["tag_id"].to_i

  end

  def self.delete_all
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def save
    if @type == "purchase"
      @amount = @amount*-100
    else
      @amount=@amount*100
    end
    sql = "INSERT INTO transactions(description, amount, t_date, type, merchant_id, tag_id) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id"
    values = [@description, @amount, @t_date, @type, @merchant_id, @tag_id]

    result = SqlRunner.run(sql, values)
    @id = result.first["id"].to_i
  end

  def edit
    sql = "UPDATE transactions SET (description, amount, t_date, type, merchant_id, tag_id) = ($1, $2, $3, $4, $5, $6) WHERE id = $7"
    values = [@description, @amount, @t_date, @type, @merchant_id, @tag_id, @id]
    SqlRunner.run(sql,values)

  end

  def delete_one
    sql = "DELETE FROM transactions WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find_all
    sql = "SELECT * FROM transactions ORDER BY t_date DESC"
    result = SqlRunner.run(sql)
    transaction_list = result.map{|transaction| Transaction.new(transaction)}
  end

  def self.find_transaction_by_id(id)
    sql = "SELECT * FROM transactions WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    transaction_list = Transaction.new(result.first)
  end

  def self.find_transaction_by_merchant(m_id)
    sql = "SELECT * FROM transactions WHERE merchant_id = $1 ORDER BY t_date DESC"
    values = [m_id]
    result = SqlRunner.run(sql, values)
    transaction_list = result.map{|transaction| Transaction.new(transaction)}
  end

  def self.find_transaction_by_tag(t_id)
    sql = "SELECT * FROM transactions WHERE tag_id = $1 ORDER BY t_date DESC"
    values = [t_id]
    result = SqlRunner.run(sql, values)
    transaction_list = result.map{|transaction| Transaction.new(transaction)}
  end

  # def self.find_transaction_by_date()
  #   sql = "SELECT * FROM transactions ORDER BY t_date DESC"
  #   result = SqlRunner.run(sql)
  #   transaction_list = result.map{|transaction| Transaction.new(transaction)}
  # end

  def self.current_balance
    transaction_array = Transaction.find_all
    amount_array = transaction_array.map{|transaction| transaction.amount}
    balance = (amount_array.sum)

  end
  def self.income_last_30_days
    sql = "SELECT * FROM transactions t WHERE t.type = 'pay in' AND t.t_date BETWEEN (current_date-30) AND current_date"
    transaction_array = SqlRunner.run(sql)
    object_array = transaction_array.map{|object| Transaction.new(object)}
    amount_array = object_array.map{|transaction| transaction.amount}
    balance = (amount_array.sum)

  end
  def self.outgoings_last_30_days

    sql = "SELECT * FROM transactions t WHERE t.type = 'purchase' AND t.t_date BETWEEN (current_date-30) AND current_date"
    transaction_array = SqlRunner.run(sql)
    object_array = transaction_array.map{|object| Transaction.new(object)}
    amount_array = object_array.map{|transaction| transaction.amount}
    balance = ((amount_array.sum))
    balance = balance*(-1)
  end
end
