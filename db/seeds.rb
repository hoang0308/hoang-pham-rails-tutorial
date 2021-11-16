User.create!(name: "hoang",
    gender: "Male",
    age: "1998-01-01",
    email: "hoang@gmail.com",
    password: "123456",
    password_confirmation: "123456",
    user_type: 1,
    status: 1,
    status_at: Time.zone.now)
99.times do |n|
    name = "hoang-#{n+1}"
    gender = "Male"
    age = "1998-01-01"
    email = "hoang#{n+1}@gmail.com"
    password = "123456"
    User.create!(name: name,
    gender: gender,
    age: "1998-01-01",
    email: email,
    password: password,
    password_confirmation: password,
    status: 1,
    status_at: Time.zone.now)
end
