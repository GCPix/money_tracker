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
end
