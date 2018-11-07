require 'faker'

class MovieFaker 
    @movie = {
    adult: Faker::Boolean.boolean(0.2),
    budget: Faker::Number.number(5),
    homepage: Faker::Avatar.image,
    overview: Faker::Lorem.paragraph + " " + Faker::Lorem.paragraph,
    popularity: Faker::Number.number(3),
    release_date: Faker::Date.between(Date.today.prev_year, Date.today),
    runtime: Faker::Number.number(7),
    in_cinema: Faker::Boolean.boolean(),
    title: Faker::Book.title,
    vote_average:  Faker::Number.number(3),
    vote_count: Faker::Number.number(4)
    }
    
    def get_rand_movie
        Movie.new(@movie)
    end
end
