# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user1 = User.new(
      :name                  => "Mikel",
      :email                 => "mikel@ironhack.com",
      :password              => "123456",
      :password_confirmation => "123456"
  )
user1.save!

user2 = User.new(
      :name                  => "Alex",
      :email                 => "alex@ironhack.com",
      :password              => "123456",
      :password_confirmation => "123456"
  )
user2.save!

puts "Users created"

group1 = Group.create(name: "Ironhackers", description: "Los mejores Ironhacker de la historia")
group2 = Group.create(name: "Teamhackers", description: "Los mejores Teamhacker de la historia")

puts "Groups created"

house1 = House.create(latitude: "40.438785", longitude: "-3.698664", address: "Calle Vargas, 3", rooms: 4, description: "sahdosahfodhf oahdsoifh oidshfoihasdoif hoadsfo hiodhsoifhoiadhs")
house2 = House.create(latitude: "40.438781", longitude: "-3.681349", address: "Calle de Núñez de Balboa, 127", rooms: 10, description: "sahdosahfodhf oahdsoifh oidshfoihasdoif hoadsfo hiodhsoifhoiadhs")

puts "Houses created"

group1.house = house1
group1.save!
group2.house = house2
group2.save!

user1.group = group1
user1.save!
user2.group = group2
user2.save!

puts "Relations created"
