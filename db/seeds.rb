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

require_relative  'faker/data'

movies = [] 
actors = []
directors = []
crews = []
writers = []


1..30.times{
    movies << get_rand_movie
}

1..100.times{
    actors << get_rand_actor
    directors << get_rand_director
    crews << get_rand_crew
    writers << get_rand_writer
}

actors.each(&:save)
directors.each(&:save)
crews.each(&:save)
writers.each(&:save)

movies.each{|movie|
    actors.sample(rand(1..99)).each{|actor|
        movie.actors << actor
        actor.movies << movie 
        actor.save!
    }
    
    directors.sample(rand(1..3)).each{|director|
        movie.directors << director
        director.movies << movie 
        director.save!
    }
    
    crews.sample(rand(1..99)).each{|crew|
        movie.crews << crew
        crew.movies << movie 
        crew.save!
    }
    
    writers.sample(rand(1..3)).each{|writer|
        movie.writers << writer
        writer.movies << movie 
        writer.save!
    }
    movie.save!
}


