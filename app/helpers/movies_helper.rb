module MoviesHelper
  def create_or_find_actors(movie, params)
    return unless params[:actors]
    created_actors = []
    params[:actors].each do |actor|
      actor_id = actor[:_id]
      begin
        if actor_id
          @actor = Actor.find(actor_id)
          movie.actors.push(@actor)
          @actor.movies.push(movie)
          @actor.save!
          next
        end
      rescue Mongoid::Errors::DocumentNotFound
        raise Error::ActorError,
              _message = "Failed to Find Actor with id #{actor_id}"
      end

      @actor = Actor.new(actor)
      @actor.validate
      unless @actor.errors.messages.empty?
        @actor.errors.messages.each do |key, er|
          created_actors.each(&:destroy!)
          raise ArgumentError,
                "Failed to create Actor. #{key.to_s.humanize} #{er[0]}"
        end
      end
      @actor.movies.push(movie)
      @actor.save
      created_actors.push(@actor)
      movie.actors.push(@actor)
    end
  end

  def find_genres(movies, params)
    return unless params[:genres]
    params[:genres].each do |genre|
      begin
        movies.genres.push(Genre.find_by(type: genre))
      rescue Mongoid::Errors::DocumentNotFound
        raise Error::ActorError,
              _message = "Failed to Find Genre with type #{genre}"
      end
    end
  end
end
