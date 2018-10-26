module MoviesHelper
  def create_or_find_movie_attributes(movie, params)
    return if params[:actors].blank?
    params[:actors].each{|model_params|
      @model = Actor.find_or_create_by(id: model_params[:_id] || '') do |actor|
        (model_params[:phone_numbers] || []).each{|phone_number_params|
          Phonenumber.find_or_create_by(id: phone_number_params[:_id] || '') do |number|
            number.update(phone_number_params)
            actor.phone_numbers.push(number)
          end
        }
      end
      @model.update(model_params)
      movie.actors.push(@model)
      movie.save!
    }
    
    params[:crews].each{|model_params|
      @model = Crew.find_or_create_by(id: model_params[:_id] || '') do |crew|
        (model_params[:phone_numbers] || []).each{|phone_number_params|
          Phonenumber.find_or_create_by(id: phone_number_params[:_id] || '') do |number|
            number.update(phone_number_params)
            crew.phone_numbers.push(number)
          end
        }
      end
      @model.update(model_params)
      movie.crews.push(@model)
      movie.save!
    }
    
    params[:directors].each{|model_params|
      @model = Director.find_or_create_by(id: model_params[:_id] || '') do |director|
        (model_params[:phone_numbers] || []).each{|phone_number_params|
          Phonenumber.find_or_create_by(id: phone_number_params[:_id] || '') do |number|
            number.update(phone_number_params)
            director.phone_numbers.push(number)
          end
        }
      end
      @model.update(model_params)
      movie.directors.push(@model)
      movie.save!
    }
    
    params[:writers].each{|model_params|
      @model = Writer.find_or_create_by(id: model_params[:_id] || '') do |writer|
        (model_params[:phone_numbers] || []).each{|phone_number_params|
          Phonenumber.find_or_create_by(id: phone_number_params[:_id] || '') do |number|
            number.update(phone_number_params)
            writer.phone_numbers.push(number)
          end
        }
      end
      @model.update(model_params)
      movie.writers.push(@model)
      movie.save!
    }
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
