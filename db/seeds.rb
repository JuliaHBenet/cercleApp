# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Room.create(name: "Sala 21", status: 1)
Room.create(name: "Sala 22", status: 1)
Room.create(name: "Sala 23", status: 1)
Room.create(name: "Sala 24", status: 1)
Room.create(name: "Sala 25", status: 1)
Room.create(name: "Sala 26", status: 1)
Room.create(name: "Sala 27", status: 1)

Booking.create(activityname: "primer lloguer", activitydescription: "el primer lloguer de tots", bookingstart: "02/07/2018", bookingend: "04/07/2018", client: Client.all.sample, user: User.all.sample, room: Room.all.sample)
Booking.create(activityname: "segon lloguer", activitydescription: "el segon lloguer de tots", bookingstart: "05/07/2018", bookingend: "06/07/2018", client: Client.all.sample, user: User.all.sample, room: Room.all.sample)
Booking.create(activityname: "tercer lloguer", activitydescription: "el tercer lloguer de tots", bookingstart: "07.07.2018", bookingend: "09.07.2018", client: Client.all.sample, user: User.all.sample, room: Room.all.sample)

Client.create(name: "julia", idcard: "22222", contactname: "Julia", contactphone1: "664847321", contactemail: "julia@julia.com")
Client.create(name: "julia2", idcard: "22233", contactname: "Julia2", contactphone1: "664847322", contactemail: "julia2@julia.com")
Client.create(name: "julia3", idcard: "22244", contactname: "Julia3", contactphone1: "664847323", contactemail: "julia3@julia.com")
Client.create(name: "julia4", idcard: "22245", contactname: "Julia4", contactphone1: "664847325", contactemail: "julia4@julia.com", lloguer: true)
Client.create(name: "julia5", idcard: "22246", contactname: "Julia5", contactphone1: "664847324", contactemail: "julia5@julia.com", lloguer: true)

User.create(name: "xaviuser")
User.create(name: "juliauser")
