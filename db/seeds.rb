User.create!(name: "hoang",
    gender: "Male",
    age: "1998-01-01",
    email: "hoang@gmail.com",
    password: "123456",
    password_confirmation: "123456",
    admin: true)
99.times do |n|
    name = "hoang-#{n+1}"
    gender = "Male",
    age = "1998-01-01",
    email = "hoang#{n+1}@gmail.com"
    password = "123456"
    User.create!(name: name,
    gender: gender,
    age: age,
    email: email,
    password: password,
    password_confirmation: password)
end
