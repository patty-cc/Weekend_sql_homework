require( 'pry-byebug')
require_relative('../models/Customer.rb')
require_relative('../models/Film.rb')
require_relative('../models/Ticket.rb')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({ 'name' => 'Iain', 'funds' => '50' })
customer1.save()
customer2 = Customer.new({ 'name' => 'Colleen', 'funds' => '60'})
customer2.save()
customer3 = Customer.new({ 'name' => 'Tommy', 'funds' => '30'})
customer3.save()

film1 = Film.new({ 'title' => 'Conspiracy Theory', 'price' => '20'})
film1.save()
film2 = Film.new({ 'title' => 'The Matrix', 'price' => '15'})
film2.save()
film3 = Film.new({ 'title' => 'Baywatch', 'price' => '18'})
film3.save()
film4 = Film.new({ 'title' => 'Guardians of the Galaxy 2', 'price' => '25'})
film4.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film3.id})
ticket2.save()
ticket3 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id})
ticket3.save()
ticket4 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id})
ticket4.save()
ticket5 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film2.id})
ticket5.save()
ticket6 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film4.id})
ticket6.save()

binding.pry
nil
