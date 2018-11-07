# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# Genre.create(type: 'romance')
# Genre.create(type: 'action')
# Genre.create(type: 'comedy')

# require 'faker/movie'

# puts MovieFaker.new().get_rand_movie

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
    
    
puts get_rand_movie.to_json



