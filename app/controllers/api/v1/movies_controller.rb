module Api
  module V1
    class MoviesController < ApplicationController
      before_action :set_Movie, only: [:show, :edit, :update, :destroy]

      # GET /Movies
      # GET /Movies.json
      def index
        @Movies = Movie.all
      end

      # GET /Movies/1
      # GET /Movies/1.json
      def show
      end

      # GET /Movies/new
      def new
        @Movie = Movie.new
      end

      # GET /Movies/1/edit
      def edit
      end

      # Movie /Movies
      # Movie /Movies.json
      def create
        @Movie = Movie.new(Movie_params)

        respond_to do |format|
          if @Movie.save
            format.html { redirect_to @Movie, notice: 'Movie was successfully created.' }
            format.json { render :show, status: :created, location: @Movie }
          else
            format.html { render :new }
            format.json { render json: @Movie.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /Movies/1
      # PATCH/PUT /Movies/1.json
      def update
        respond_to do |format|
          if @Movie.update(Movie_params)
            format.html { redirect_to @Movie, notice: 'Movie was successfully updated.' }
            format.json { render :show, status: :ok, location: @Movie }
          else
            format.html { render :edit }
            format.json { render json: @Movie.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /Movies/1
      # DELETE /Movies/1.json
      def destroy
        @Movie.destroy
        respond_to do |format|
          format.html { redirect_to Movies_url, notice: 'Movie was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_Movie
        @Movie = Movie.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def Movie_params
        params.require(:Movie).permit(:name, :title, :content)
      end
    end
  end
end
