# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"

# Remove all data to start.
Product.delete_all
Category.delete_all
puts "Cleared all data."

puts Product.inspect

filename = Rails.root.join("db/ecommerce_products.csv")
puts "Loading Product Data From: #{filename}"
product_data = File.read(filename, encoding: "bom|utf-8")
products = CSV.parse(product_data, headers: true)

puts "Loaded #{products.size} rows from the CSV file."

products.each do |p|
  category = Category.find_or_create_by(category_name: p["Category"])

  if category&.valid?
    # Create the product
    product = category.products.create(
      product_name: p["Name"],
      description:  p["Description"],
      price:        p["Price"],
      company:      p["Company"]
    )

    unless product.valid?
      puts "Invalid Product #{p['Name']}"
      puts product.errors.messages
      next
    end

  else
    puts "Invalid category #{p['Category']} for product #{p['Name']}."
    puts category.errors.messages

  end
end

puts "Created #{Category.count} Categories."
puts "Created #{Product.count} Products."
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?