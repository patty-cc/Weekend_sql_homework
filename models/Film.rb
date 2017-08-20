require('pg')
require_relative('../db/sql_runner')

class Film

  attr_accessor(:title, :price)
  attr_reader(:id)

  def initialize(film_array)
   @id = film_array['id'].to_i if film_array['id']
   @title = film_array['title']
   @price = film_array['price']
  end


  def Film.all()
    sql = 'SELECT * FROM films;'
    result = SqlRunner.run(sql)
    films = result.map{|film_hash| Film.new(film_hash)}
    return films
  end

  def customer()
    sql = ' SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE film_id = $1;'
    values = [@id]
    customers = SqlRunner.run( sql, values )
    result = customers.map{ |customer| Customer.new(customer)}
    return result
  end

  def save()

    sql = '
      INSERT INTO films (
      title,
      price
      ) VALUES (
      $1, $2
      )
      RETURNING id;'
    values = [@title, @price,]
    data = SqlRunner.run( sql, values )[0]
    @id = data['id'].to_i

  end

  def Film.delete_all

    sql = 'DELETE FROM films;'
    values = []
    SqlRunner.run( sql, values )

  end

  def delete
    sql = 'DELETE FROM films
    WHERE id = $1;'
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def update()
    sql = 'UPDATE films SET (
    title,
    price
    ) = (
    $1, $2
    ) WHERE id = $3;'
    values = [@title, @price, @id]
    SqlRunner.run( sql, values )
  end

end
