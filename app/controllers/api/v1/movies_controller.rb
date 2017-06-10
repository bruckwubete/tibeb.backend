module Api
  module V1
    class MoviesController < ApplicationController
      #before_action :authenticate_user!
      before_action :set_movie, only: [:show]



      # GET /movies/1
      # GET /movies/1.json
      def show
      end

      # GET /movies/popular
      # GET /movies/popular.json
      def popular
        @api_response = Tmdb::Movie.popular
        @movies = []
        @api_response.results.each do |movie|
          @movies.push(movie.to_h)
        end
      end

      # GET /movies/search/:title
      # GET /movies/search.json

      def search
        @api_response = Tmdb::Search.movie(params[:title]).to_h
        @api_response[:results].each_with_index do |movie, index|
          @api_response[:results][index] = movie.to_h
        end
      end
      
       # GET /movies/discover
      # GET /movies/discover.json

      def discover
        @api_response = Tmdb::Discover.movie(params).to_h
        @api_response[:results].each_with_index do |movie, index|
          @api_response[:results][index] = movie.to_h
        end
      end
      
      # GET /movies/genres
      # GET /movies/genres.json

      def genres
        @api_response = Tmdb::Genre.movie_list
        @api_response.each_with_index do |genre, index|
          @api_response[index] = genre.to_h
        end
      end



      private
        # Use callbacks to share common setup or constraints between actions.
      def set_movie
        begin
          @movie = Tmdb::Movie.detail(params[:id].to_i).to_h
          get_more_info params[:id].to_i
          toHash = [:genres, :production_companies, :production_countries, :spoken_languages, :cast, :crew, :director, :videos]
          toHash.each do |prop|
            convert_to_hash prop
          end
        rescue Tmdb::Error => e
          @movie = []
        end
      end

      def get_more_info id
        begin
          crew =  Tmdb::Movie.crew(id)
          @movie[:crew] = crew

          cast =  Tmdb::Movie.cast(id)
          @movie[:cast] = cast

          director =  Tmdb::Movie.director(id)
          @movie[:director] = director

          videos =  Tmdb::Movie.videos(id)
          @movie[:videos] = videos

        rescue Tmdb::Error => e
          puts e
        end
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def movie_params
        params.fetch(:movie, {})
      end

      def convert_to_hash prop
        @movie[prop].each_with_index do |item, index|
          @movie[prop][index] = item.to_h
        end
      end
    end
  end
end
