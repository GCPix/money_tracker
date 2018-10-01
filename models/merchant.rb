require_relative('../db/sql_runner')

class Merchant

  attr_reader :id
  attr_accessor :name

  def initialize(options)
  @id = options["id"].to_i if options["id"]
  @name = options["name"]
  end

  def save
    sql = "INSERT INTO merchants(name) VALUES ($1) RETURNING id"
    values = [@name]

    result = SqlRunner.run(sql, values)
    @id = result.first["id"].to_i
  end

  def self.find_all
    sql = "SELECT * FROM merchants"
    result = SqlRunner.run(sql)
    merchant_list = result.map{|merchant| Merchant.new(merchant)}

  end
  def self.find(id)
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [id]

    list = SqlRunner.run(sql,values)
    result = Merchant.new(list.first)
  end
  def edit
    sql = "UPDATE merchants SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql,values)

  end

  def delete_one
    sql = "DELETE FROM merchants WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end

  def self.usage_frequency
    sql = "SELECT m.id, COUNT(t.merchant_id) AS count FROM merchants m LEFT JOIN transactions t ON m.id = t.merchant_id GROUP BY m.id ORDER BY count DESC"
    result = SqlRunner.run(sql)
    count_list = result.map{|item| item}
    return count_list

  end


  def self.all_transactions(id)
    sql = "SELECT * FROM transactions WHERE merchant_id = $1 ORDER BY t_date DESC"
    values = [id]
    result = SqlRunner.run(sql,values)
    return list = result.map{|item| Transaction.new(item)}
  end

  def self.total_amount_by_merchant

    sql = "SELECT m.name, SUM(t.amount) AS sum FROM merchants m INNER JOIN transactions t ON m.id = t.merchant_id AND t.type = 'purchase' GROUP BY m.name ORDER BY sum DESC"
    result = SqlRunner.run(sql)
    sum_list = result.map{|item| item}
    return values = sum_list.map{|hash| hash.values}

  end
end
