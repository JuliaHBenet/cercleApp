# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Room.create(name: "Consell", status: 1)
Room.create(name: "Sala 21", status: 1)
Room.create(name: "Sala 22", status: 1)
Room.create(name: "Sala TV", status: 1)
Room.create(name: "Descans", status: 1)
Room.create(name: Room::ESCENARI, status: 1)
Room.create(name: "Capella", status: 1)
Room.create(name: "Caus", status: 1)
Room.create(name: Room::GOLFES, status: 1)
Room.create(name: "Dansa", status: 1)
