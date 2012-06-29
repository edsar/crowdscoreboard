# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


 StatisticType.delete_all   
 StatisticType.create!( :code => "FGM", :points => 2)
 StatisticType.create!( :code => "3PM", :points => 3)
 