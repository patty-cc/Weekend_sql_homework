require('pg')
require_relative('../db/sql_runner')

class Customer

  attr_accessor(:name, :funds)
  attr_reader(:id)

  def initialize(customer_array)
    @id = customer_array['id'].to_i if customer_array['id']
    @name = customer_array['name']
    @funds = customer_array['funds'].to_i
  end

  def films()
    sql = '
    SELECT films.* FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE customer_id = $1;'
    values = [@id]
    films = SqlRunner.run(sql, values)
    result = films.map{ |film| Film.new(film)}
    return result
  end

  def Customer.all()
    sql = 'SELECT * FROM customers;'
    result = SqlRunner.run(sql)
    customers = result.map{|customer_hash| Customer.new(customer_hash)}
    return customers
  end

  def save

    sql = '
    INSERT INTO customers (
      name,
      funds
    ) VALUES (
      $1, $2
    )
      RETURNING *;'
    values = [@name, @funds]
    data = SqlRunner.run( sql, values )[0]
    @id = data['id'].to_i

  end

  def Customer.delete_all
    sql = 'DELETE FROM customers;'
    values = []
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = 'DELETE FROM customers
    WHERE id = $1;'
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def update()
    sql = 'UPDATE customers SET (
    name,
    funds
    ) = (
    $1, $2
    ) WHERE id = $3;'
    values = [@name, @funds, @id]
    SqlRunner.run( sql, values )
  end

end
