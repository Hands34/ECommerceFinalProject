# This file should contain all the record creation
# needed to seed the database with its default values.

# The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"

# Remove all data to start.
Province.delete_all
Product.delete_all
Category.delete_all
AdminUser.delete_all
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
    query = URI.encode_www_form_component([product.product_name, category.category_name].join(","))
    downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{query}")
    product.image.attach(io:       downloaded_image,
                         filename: "m-#{[product.product_name, category.category_name].join('-')}.jpg")

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

mb = Province.create(name: "Manitoba", tax_rate: 12)
unless mb.valid?
  puts "Invalid  Province "
  puts mb.errors.messages
end
ab = Province.create(name: "Alberta", tax_rate: 5)
unless ab.valid?
  puts "Invalid  Province "
  puts ab.errors.messages
end
bc = Province.create(name: "British Columbia", tax_rate: 12)
unless bc.valid?
  puts "Invalid  Province "
  puts bc.errors.messages
end
nb = Province.create(name: "New Brunswick", tax_rate: 15)
unless nb.valid?
  puts "Invalid  Province "
  puts nb.errors.messages
end
nfl = Province.create(name: "Newfoundland and Labrador", tax_rate: 15)
unless nfl.valid?
  puts "Invalid  Province "
  puts nfl.errors.messages
end
nwt = Province.create(name: "Northwest Territories", tax_rate: 5)
unless nwt.valid?
  puts "Invalid  Province "
  puts nwt.errors.messages
end
ns = Province.create(name: "Nova Scotia", tax_rate: 15)
unless ns.valid?
  puts "Invalid  Province "
  puts ns.errors.messages
end
nt = Province.create(name: "Nunavut", tax_rate: 5)
unless nt.valid?
  puts "Invalid  Province "
  puts nt.errors.messages
end
on = Province.create(name: "Ontario", tax_rate: 13)
unless on.valid?
  puts "Invalid  Province "
  puts on.errors.messages
end
pei = Province.create(name: "Prince Edward Island", tax_rate: 15)
unless pei.valid?
  puts "Invalid  Province "
  puts pei.errors.messages
end
qc = Province.create(name: "Quebec", tax_rate: 15)
unless qc.valid?
  puts "Invalid  Province "
  puts qc.errors.messages
end
sk = Province.create(name: "Saskatchewan", tax_rate: 11)
unless sk.valid?
  puts "Invalid  Province "
  puts sk.errors.messages
end
yk = Province.create(name: "Yukon", tax_rate: 5)
unless yk.valid?
  puts "Invalid  Province "
  puts yk.errors.messages
end

puts "Created #{Province.count} Provinces."
puts "Created #{Category.count} Categories."
puts "Created #{Product.count} Products."
if Rails.env.development?
  AdminUser.create!(email: "admin@example.com",
     password: "password", password_confirmation: "password")
end
