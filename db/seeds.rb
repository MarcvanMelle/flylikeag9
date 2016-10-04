# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  { username: "mega_beef", email: "mega_beef@gmail.com", password: "password", password_confirmation: "password" }
)

Word.create([
  { word: "omnipotent", definition: "not Kyle", user_id: 1 },
  { word: "talented", definition: "not Kyle", user_id: 1},
  { word: "programmer", definition: "not Kyle", user_id: 1},
  { word: "handsome", definition: "not Kyle", user_id: 1},
  { word: "friend", definition: "not Kyle", user_id: 1},
  { word: "successful", definition: "not Kyle", user_id: 1},
  { word: "clean", definition: "not Kyle", user_id: 1},
  { word: "clever", definition: "not Kyle", user_id: 1},
  { word: "thin", definition: "not Kyle", user_id: 1},
  { word: "sober", definition: "not Kyle", user_id: 1},
  { word: "indispensible", definition: "not Kyle", user_id: 1},
  { word: "leader", definition: "not Kyle", user_id: 1},
  { word: "buff", definition: "not Kyle", user_id: 1},
  { word: "fashionable", definition: "not Kyle", user_id: 1},
  { word: "1omnipotent", definition: "not Kyle", user_id: 1 },
  { word: "1talented", definition: "not Kyle", user_id: 1},
  { word: "1programmer", definition: "not Kyle", user_id: 1},
  { word: "1handsome", definition: "not Kyle", user_id: 1},
  { word: "1friend", definition: "not Kyle", user_id: 1},
  { word: "1successful", definition: "not Kyle", user_id: 1},
  { word: "1clean", definition: "not Kyle", user_id: 1},
  { word: "1clever", definition: "not Kyle", user_id: 1},
  { word: "1thin", definition: "not Kyle", user_id: 1},
  { word: "1sober", definition: "not Kyle", user_id: 1},
  { word: "1indispensible", definition: "not Kyle", user_id: 1},
  { word: "1leader", definition: "not Kyle", user_id: 1},
  { word: "1buff", definition: "not Kyle", user_id: 1},
  { word: "1fashionable", definition: "not Kyle", user_id: 1},
])
