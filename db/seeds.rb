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
Room.create(name: "Golfes", status: 1)
Room.create(name: "Dansa", status: 1)

Event.create(name: "primer lloguer", description: "el primer lloguer de tots", eventstart: "02/07/2018", eventend: "04/07/2018", client: Client.all.sample, user: User.all.sample, room: Room.all.sample)
Event.create(name: "segon lloguer", description: "el segon lloguer de tots", eventstart: "05/07/2018", eventend: "06/07/2018", client: Client.all.sample, user: User.all.sample, room: Room.all.sample)
Event.create(name: "tercer lloguer", description: "el tercer lloguer de tots", eventstart: "07.07.2018", eventend: "09.07.2018", client: Client.all.sample, user: User.all.sample, room: Room.all.sample)

Client.create(name: "julia", idcard: "22222", contactname: "Julia", contactphone1: "664847321", contactemail: "julia@julia.com")
Client.create(name: "julia2", idcard: "22233", contactname: "Julia2", contactphone1: "664847322", contactemail: "julia2@julia.com")
Client.create(name: "julia3", idcard: "22244", contactname: "Julia3", contactphone1: "664847323", contactemail: "julia3@julia.com")
Client.create(name: "julia4", idcard: "22245", contactname: "Julia4", contactphone1: "664847325", contactemail: "julia4@julia.com", lloguer: true)
Client.create(name: "julia5", idcard: "22246", contactname: "Julia5", contactphone1: "664847324", contactemail: "julia5@julia.com", lloguer: true)

User.create(name: "oneuser", role: "admin")
User.create(name: "juliauser", role: "premium")
