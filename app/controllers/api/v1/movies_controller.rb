module Api
  module V1
    class MoviesController < ApplicationController
      before_action :set_Movie, only: [:show, :edit, :update, :destroy]

      # GET /Movies
      # GET /Movies.json
      def index
        @movies = Movie.all
      end

      # GET /Movies/1
      # GET /Movies/1.json
      def show; end

      # GET /Movies/new
      def new
        @movie = Movie.new
        respond_to do |format|
          if @movie
            format.json { render :show, status: :created }
          else
            format.json do
              render json: @movie.errors, status: :unprocessable_entity
            end
          end
        end
      end

      # GET /Movies/1/edit
      def edit; end

      # Movie /Movies
      # Movie /Movies.json
      def create
        @movie = Movie.new(movie_params)

        respond_to do |format|
          if @movie.save
            format.json { render :show, status: :created}
          else
            format.json { render json: @movie.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /Movies/1
      # PATCH/PUT /Movies/1.json
      def update
        respond_to do |format|
          if @movie.update(Movie_params)
            format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
            format.json { render :show, status: :ok, location: @movie }
          else
            format.html { render :edit }
            format.json { render json: @movie.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /Movies/1
      # DELETE /Movies/1.json
      def destroy
        @movie.destroy
        respond_to do |format|
          format.html { redirect_to @movie, notice: 'Movie was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_Movie
        @movie = Movie.find(params[:id])
      end

      # Never trust parameters from the scary internet.
      # Only allow the white list through.
      # @return [Object]
      def movie_params
        params.permit(:title)
      end
    end
  end
end
