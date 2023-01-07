# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
teas = create_list(:tea, 12)
customers = create_list(:customer, 3)

create_list(:subscription, 4, customer: customers[0], teas: teas)
create_list(:subscription, 5, customer: customers[1], teas: teas)
create_list(:subscription, 6, customer: customers[2], teas: teas)