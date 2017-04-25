5.times do |i|
  user = User.create(name: "user#{i}", email: "user#{i}@gmail.com", password: "password", password_confirmation: "password")
  
  30.times do |i|
    user.products.create(name: "#{user.name}#{i}", price: Random.rand(100..999))
  end
end
