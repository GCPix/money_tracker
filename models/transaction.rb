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

  def self.delete_all
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def save
    if @type == "purchase"
      @amount = @amount*-1
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
end
