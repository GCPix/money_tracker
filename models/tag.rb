require_relative('../db/sql_runner')

class Tag

  attr_reader :id
  attr_accessor :name

  def initialize(options)
  @id = options["id"].to_i if options["id"]
  @name = options["name"].capitalize
  end

  def self.find_all
    sql = "SELECT * FROM tags"
    result = SqlRunner.run(sql)
    tag_list = result.map{|tag| Tag.new(tag)}

  end
  def self.find(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]

    list = SqlRunner.run(sql,values)
    result = Tag.new(list.first)
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
    sql = "UPDATE tags SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql,values)

  end

  def delete_one
    sql = "DELETE FROM tags WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.usage_frequency
    sql = "SELECT tags.id, COUNT(transactions.tag_id) AS count FROM tags LEFT JOIN transactions ON tags.id = transactions.tag_id GROUP BY tags.id ORDER BY count DESC"
    result = SqlRunner.run(sql)
    count_list = result.map{|item| item}
    return count_list

  end

  def self.all_transactions(id)
    sql = "SELECT * FROM transactions WHERE tag_id = $1 ORDER BY t_date DESC"
    values = [id]
    result = SqlRunner.run(sql,values)
    return list = result.map{|item| Transaction.new(item)}
  end

  def self.total_amount_by_tag

    sql = "SELECT tags.name, SUM(t.amount) AS sum FROM tags INNER JOIN transactions t ON tags.id = t.tag_id AND t.type = 'Purchase' GROUP BY tags.name ORDER BY sum DESC"
    result = SqlRunner.run(sql)
    sum_list = result.map{|item| item}
    return values = sum_list.map{|hash| hash.values}


  end
end
