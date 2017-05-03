admin = User.create(name: "admin", email: "admin@gmail.com", is_admin: true, password: "password", password_confirmation: "password")

puts '--- admin created --- '

10.times do |i|
  user = User.create(name: "user #{i}", email: "user#{i}@gmail.com", password: "password", password_confirmation: "password")
end

puts '--- users created --- '

30.times do |i|
  admin.products.create(name: "product ##{i}", price: Random.rand(100..999))
end

puts '--- products created --- '
