require('pg')
require_relative('../db/sql_runner')

class Ticket

  attr_reader(:id, :customer_id, :film_id)

  def initialize(ticket_array)
    @id = ticket_array['id'].to_i if ticket_array['id']
    @customer_id = ticket_array['customer_id'].to_i
    @film_id = ticket_array['film_id'].to_i
  end

  def film()
    sql = '
    SELECT * FROM films
    WHERE id = $1;'
    values = [@film_id]
    film_data = SqlRunner.run(sql, values)[0]
    return Film.new(film_data)
  end

  def customer()
    sql = '
    SELECT * FROM customers
    WHERE id = $1;'
    values = [@customer_id]
    customer_data = SqlRunner.run( sql, values)[0]
    return Customer.new(customer_data)
  end

  def save()
    sql = '
    INSERT INTO tickets (
    customer_id,
    film_id
    ) VALUES (
    $1, $2
    )
    RETURNING *;'
    values = [@customer_id, @film_id]
    data = SqlRunner.run( sql, values )[0]
    @id = data['id'].to_i
  end

  def Ticket.delete_all

    sql = 'DELETE FROM tickets;'
    values = []
    SqlRunner.run( sql, values )

  end

  def delete()
    sql = 'DELETE FROM tickets
    WHERE id = $1;'
    values = [@id]
    SqlRunner.run( sql, values )
  end


end
