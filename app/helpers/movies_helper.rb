module MoviesHelper
  def create_or_find_actors(movie, params)
    return if params[:actors].blank?
    params[:actors].each{|actor_params|
      @actor = Actor.find_or_create_by(id: actor_params[:_id] || '') do |actor|
        (actor_params[:phone_numbers] || []).each{|phone_number_params|
          Phonenumber.find_or_create_by(id: phone_number_params[:_id] || '') do |number|
            number.update(phone_number_params)
            actor.phone_numbers.push(number)
          end
        }
      end
      @actor.update(actor_params)
      movie.actors.push(@actor)
      movie.save!
    }
  end
  
  def create_or_find_actors2(movie, params)
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

      parameters = actor.dup
      parameters.delete(:phone_numbers)
      @actor = Actor.new(parameters)
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
      @actor.save_phone_number(actor[:phone_numbers][0]) if actor[:phone_numbers] && actor[:phone_numbers][0]
      #@actor.save_image()
      @actor.save
      created_actors.push(@actor)
      movie.actors.push(@actor)
    end
  end

  def find_genres(movie, params)
    return unless params[:genres]
    params[:genres].each do |genre_type|
      begin
        movie.genres.push(Genre.find_by(type: genre_type))
      rescue Mongoid::Errors::DocumentNotFound
        raise Error::ActorError,
              _message = "Failed to Find Genre with type #{genre_type}"
      end
    end
  end
end
