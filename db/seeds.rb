# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"

# Remove all data to start.

filename = Rails.root.join("db/ecommerce_products.csv")
puts "Loading Product Data From: #{filename}"
product_data = File.read(filename)
products = CSV.parse(product_data, headers: true)

puts "Loaded #{products.size} rows from the CSV file."

products.each do |p|
  category = Category.find_or_create_by(name: p["Category"])

  next unless category&.valid?

  # Create the product
  product = category.products.create(
    product_name: p["Name"],
    description:  p["Description"],
    price:        p["Price"],
    company:      p["Company"]
  )

  unless product.valid?
    puts "Invalid Product #{p['Name']}"
    next
  end
end

puts "Created #{Category.count} Categories."
puts "Created #{Product.count} Products."
