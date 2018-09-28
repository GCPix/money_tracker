require_relative('../db/sql_runner')

class Tag

  attr_reader :id
  attr_accessor :name

  def initialize(options)
  @id = options["id"].to_i if options["id"]
  @name = options["name"]
  end

  def self.delete_all
    sql = "DELETE FROM tags"
    SqlRunner.run(sql)
  end

  def save
    sql = "INSERT INTO tags(name) VALUES ($1) RETURNING id"
    values = [@name]

    result = SqlRunner.run(sql, values)
    @id = result.first["id"].to_i
  end

  def edit
    sql = "UPDATE tag SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql,values)

  end

  def delete_one
    sql = "DELETE FROM tags WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
end
