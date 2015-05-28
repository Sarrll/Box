# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'factory_girl_rails'

puts 'Creating Roles.'
%w(user admin super-admin).each do |role|
  Role.create(name: role)
end

puts 'Creating Admin.'
admin = FactoryGirl.create(:user, first_name: "Admin", last_name: "Chanintr", email: "sarat@chanintr.com", password: "AdminP@ssword", confirmation_token: nil, confirmed_at: DateTime.now)
admin.add_role('admin')

