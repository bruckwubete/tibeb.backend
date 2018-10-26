module Api
  module V1
    class MoviesController < ApplicationController
      #before_action :authenticate_user!
      before_action :set_movie, only: %i[show edit update destroy]

      swagger_controller :movies, 'Movies'

      swagger_api :index do
        summary 'Returns all movies'
        notes 'This lists all movies'
        param :query, 'page[number]', :integer, :optional, 'Page number'
        param :query, 'page[size]', :integer, :optional, 'Page size'
        response :unauthorized
        response :not_acceptable
        response :requested_range_not_satisfiable
      end

      # GET /Movies
      # GET /Movies.json
      def index
        page_number = params[:page] ? params[:page][:number] : 1
        page_size = params[:page]? params[:page][:size] : Rails.application.config.default_per_page
        @movies = Movie.includes(:actors).all.page(page_number).per(page_size)
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
        parameters = movie_params.dup
        parameters.delete(:images)
        parameters.delete(:genres)
        parameters.delete(:videos)
        parameters.delete(:actors)

        @movie = Movie.new(parameters)

        respond_to do |format|
          if @movie.save
            @movie.save_attachments(movie_params)
            format.json { render :show, status: :created }
          else
            format.json do
              render json: @movie.errors, status: :unprocessable_entity
            end
          end
        end
      end

      # PATCH/PUT /Movies/1
      # PATCH/PUT /Movies/1.json
      def update
        respond_to do |format|
          if @movie.update(movie_params)
            format.json { render :show, status: :ok, location: @movie }
          else
            format.json do
              render json: @movie.errors, status: :unprocessable_entity
            end
          end
        end
      end

      # DELETE /Movies/1
      # DELETE /Movies/1.json
      def destroy
        @movie.destroy
        respond_to do |format|
          format.json { head :no_content }
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_movie
        @movie = Movie.includes(:genres).find(params[:id])
      end

      # Never trust parameters from the scary internet.
      # Only allow the white list through.
      # @return [Object]
      def movie_params
        valid_params = Movie.attribute_names.reject do |item|
          item.match(/^_id/)
        end
        params.require(:title)
        valid_params.concat([:page])
        
        phone_number_params = [phone_numbers: [[:phone_number, :type]]]
        actor_params = Actor.attribute_names
        actor_params.concat(phone_number_params)
        director_params = Director.attribute_names
        director_params.concat(phone_number_params)
        crew_params = Crew.attribute_names
        crew_params.concat(phone_number_params)
        writer_params = Writer.attribute_names
        writer_params.concat(phone_number_params)
        
        valid_params.concat([images: [], videos: [], genres: [], actors: [actor_params]], directors: [director_params], crews: [crew_params], writers: [writer_params])
        params.permit(valid_params)
      end
    end
  end
end
