module Api
  module V1
    class MoviesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_movie, only: [:show, :edit, :update, :destroy]


      # GET /movies
      # GET /movies.json
      def index
        @movies = Movie.all
      end

      # GET /movies/1
      # GET /movies/1.json
      def show
      end

      # GET /movies/new
      def new
        @movie = Movie.new
      end

      # GET /movies/1/edit
      def edit
      end

      # POST /movies
      # POST /movies.json
      def create
        @movie = Movie.new(movie_params)

        respond_to do |format|
          if @movie.save
            format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
            format.json { render :show, status: :created, location: @movie }
          else
            format.html { render :new }
            format.json { render json: @movie.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /movies/1
      # PATCH/PUT /movies/1.json
      def update
        respond_to do |format|
          if @movie.update(movie_params)
            format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
            format.json { render :show, status: :ok, location: @movie }
          else
            format.html { render :edit }
            format.json { render json: @movie.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /movies/1
      # DELETE /movies/1.json
      def destroy
        @movie.destroy
        respond_to do |format|
          format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      # GET /people/popular
      # GET /people/popular.json
      def popular
        @api_response = Tmdb::Discover.movie
        @movies = []
        @api_response.results.each do |movie|
          @movies.push(movie.to_h)
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
