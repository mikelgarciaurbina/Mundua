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

hobby1 = Hobby.create(name: "Basketball")
hobby2 = Hobby.create(name: "Futball")
hobby3 = Hobby.create(name: "Tennis")
hobby4 = Hobby.create(name: "Baseball")

puts "Hobbies created"

user1.hobbies.push(hobby1)
user1.hobbies.push(hobby2)
user1.hobbies.push(hobby3)

user1.save!

user2.hobbies.push(hobby1)
user2.hobbies.push(hobby4)

user2.save!

puts "Hobbies added"

technology1 = Technology.create(name: "HTML5")
technology2 = Technology.create(name: "CSS3")
technology3 = Technology.create(name: "Ruby")
technology4 = Technology.create(name: "Ruby on Rails")
technology5 = Technology.create(name: "TDD")
technology6 = Technology.create(name: "JavaScript")
technology7 = Technology.create(name: "JQuery")

puts "Technologies created"

user1.technologies.push(technology1)
user1.technologies.push(technology2)
user1.technologies.push(technology3)
user1.technologies.push(technology4)
user1.technologies.push(technology5)
user1.save!

user2.technologies.push(technology1)
user2.technologies.push(technology4)
user2.technologies.push(technology5)
user2.technologies.push(technology6)
user2.technologies.push(technology7)
user2.save!

puts "Technologies Added"