# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creating users..."
users = %w[one two three four five].map do |name|
  User.create!(name: "#{name.capitalize} Example", email: "#{name}@example.com")
end
puts "Created #{users.size} users."

puts "Creating companies..."
companies = %w[DashiCo HashiCorp].map do |name|
  Company.create!(name: name)
end
puts "Created #{companies.size} companies."

puts "Adding users to company..."
companies.first.users << User.first(3)
companies.last.users << User.last(2)
puts "Added users to companies"

puts "Creating projects..."
projects = []
projects << Project.create!(name: "Epic Project", start_date: 2.weeks.ago, end_date: Date.current)
projects << Project.create!(name: "Medium Project", start_date: 1.week.ago, end_date: 1.day.ago)
projects << Project.create!(name: "Small Project", start_date: 3.days.ago)
projects << Project.create!(name: "Tiny Project", start_date: 1.day.ago)
puts "Created #{projects.size} projects"

puts "Done."
