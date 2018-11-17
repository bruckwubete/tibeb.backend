require_relative  'faker/data'

#seed genres
['romance', 'comedy', 'action', 'thriller', 'horror', 'documentary', 'kids', 'suspense', 'drama'].each{|type| Genre.create(type: type)}

movies = [] 
actors = []
directors = []
crews = []
writers = []
genres = Genre.all

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
    
    genres.sample(rand(1..3)).each{|genre|
        movie.genres << genre
        genre.movies << movie 
        genre.save!
    }
    
    movie.save!
}


