require 'faker'

10.times do             #cree 10 villes
        City.create!(name: Faker::Address.city, zip_code: Faker::Address.zip)
end

10.times do             #cree 10 user avec une ville en reference
        User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Quote.famous_last_words, email: Faker::Internet.email, age: rand(18..99), city: City.all.sample, password:"Majico")
end

20.times do |index|     #cree 20 gossip en reference avec user
        Gosssip.create!(title: "Gossip#{index}",content: "blablabal", user: User.all.sample)
end

10.times do             #cree 10 tag
        Tag.create!(title: "##{Faker::Games::Pokemon.name}")
end

1.upto(20) do |index|           #Fait la relation de 20 gossips avec des tags
        TagList.create!(gosssip: Gosssip.find(index), tag: Tag.all.sample)
end

20.times do             #creer 20 like qui est de maniere aleatoire un like de comment ou de gossip

        Like.create!(user: User.all.sample, gosssip: Gosssip.all.sample)

end

puts "all entries added"