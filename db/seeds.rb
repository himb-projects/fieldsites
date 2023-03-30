# Create a main sample user.
User.create!(name:  "Bob Green",
             email: "jmadin@gmail.com",
             password:              "grous9",
             password_confirmation: "grous9",
             admin:     false,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Joshua Madin",
            email: "jmadin@hawaii.edu",
            password:              "grous9",
            password_confirmation: "grous9",
            admin:     true,
            activated: true,
            activated_at: Time.zone.now)
