# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Counter.delete_all
# . . .
Counter.create(date: '2013-01-01', warm: 12, cold: 14)
Counter.create(date: '2013-02-01', warm: 13, cold: 15)
Counter.create(date: '2013-03-01', warm: 14, cold: 16)
