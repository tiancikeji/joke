# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'wanglei', :email => 'wanglei@tiantiandache.com', :password => 'woaixuexi', :password_confirmation => 'woaixuexi'
puts 'New user created: ' << user.name

user2 = User.create! :name => 'wanggeng', :email => 'wanggeng@tiantiandache.com', :password => '12345678', :password_confirmation => '12345678'
puts 'New user created: ' << user2.name

user3 = User.create! :name => 'yumingyuan', :email => 'yumingyuan@tiantiandache.com', :password => '12345678', :password_confirmation => '12345678'
puts 'New user created: ' << user3.name


user4 = User.create! :name => 'jiaken', :email => 'jiaken@tiantiandache.com', :password => '12345678', :password_confirmation => '12345678'
puts 'New user created: ' << user4.name


user5 = User.create! :name => 'jared', :email => 'jared@tiantiandache.com', :password => '12345678', :password_confirmation => '12345678'
puts 'New user created: ' << user5.name


user6 = User.create! :name => 'lijizhe', :email => 'lijizhe@tiantiandache.com', :password => '12345678', :password_confirmation => '12345678'
puts 'New user created: ' << user6.name


user7 = User.create! :name => 'zhengsongshuai', :email => 'zhengsongshuai@tiantiandache.com', :password => '12345678', :password_confirmation => '12345678'
puts 'New user created: ' << user7.name

user.add_role :admin
