require 'faker'

def get_rand_movie
    movie  = {
        adult: Faker::Boolean.boolean(0.2),
        budget: Faker::Number.number(5),
        homepage: Faker::Avatar.image,
        overview: Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph,
        popularity: Faker::Number.number(3),
        release_date: Faker::Date.between(Date.today.prev_year(50), Date.today),
        runtime: Faker::Number.number(7),
        title: Faker::Book.title,
        vote_average:  Faker::Number.number(3),
        vote_count: Faker::Number.number(4)
    }
    Movie.new(movie)
end

def get_rand_actor
    Actor.new(person_payload)
end

def get_rand_director
    Director.new(person_payload)
end

def get_rand_crew
    Crew.new(person_payload)
end

def get_rand_writer
    Writer.new(person_payload)
end

private

def person_payload
    return {
        email: Faker::Internet.email,
        first_name: Faker::Name.first_name ,
        last_name: Faker::Name.last_name ,
        nick_name: Faker::Name.unique.first_name,
        bio:  Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph,
        dob: Faker::Date.between(Date.today.prev_year(50), Date.today),
        deceased: Faker::Boolean.boolean(),
        dod: Faker::Date.between(Date.today.prev_year(50), Date.today)
    }
end

