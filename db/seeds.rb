# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users= [
    { name: 'testuser1', email: 'testuser1@yahoo.com', password_digest: 'test1' },
    { name: 'testuser2', email: 'testuser2@yahoo.com', password_digest: 'test2' },
    ]
    users.each do |record|
     User.create!(record) unless User.find_by(email: record[:email])
    end