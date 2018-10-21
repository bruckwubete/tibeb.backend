module Api
  module V1
    class DirectorsController < ApplicationController
      before_action :set_director, only: %i[show edit update destroy]
      
      swagger_controller :directors, 'Directors'

      swagger_api :index do
        summary 'Returns all directors'
        notes 'This lists all directors'
        param :query, 'page[number]', :integer, :optional, 'Page number'
        param :query, 'page[size]', :integer, :optional, 'Page size'
        response :unauthorized
        response :not_acceptable
        response :requested_range_not_satisfiable
      end

      # GET /directors
      # GET /directors.json
      def index
        page_number = params[:page] ? params[:page][:number] : 1
        page_size = params[:page]? params[:page][:size] : Rails.application.config.default_per_page
        @directors = Director.includes(:movies).all.page(page_number).per(page_size)
      end

      # GET /director/1
      # GET /director/1.json
      def show; end

      # GET /director/new
      def new
        @director = Director.new
        respond_to do |format|
          if @director
            format.json { render :show, status: :created }
          else
            format.json do
              render json: @director.errors, status: :unprocessable_entity
            end
          end
        end
      end

      # GET /directors/1/edit
      def edit; end

      # POST /director
      # POST /director.json
      def create
        parameters = director_params.dup
        parameters.delete(:images)
        parameters.delete(:videos)
        @director = Director.new(parameters)

        respond_to do |format|
          if @director.save
            @director.save_attachments(director_params)
            format.json { render :show, status: :created }
          else
            format.json { render json: @director.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /director/1
      # PATCH/PUT /director/1.json
      def update
        respond_to do |format|
          if @director.update(director_params)
            format.html { redirect_to @director, notice: 'Director was successfully updated.' }
            format.json { render :show, status: :ok, location: @director }
          else
            format.html { render :edit }
            format.json { render json: @director.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /director/1
      # DELETE /director/1.json
      def destroy
        @director.destroy
        respond_to do |format|
          format.html { redirect_to director_url, notice: 'Director was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_director
        @director = Director.find(params[:id]).page(1).per(1)
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def director_params
        valid_params = Director.attribute_names.reject do |item|
          item.match(/^_id/)
        end
        [:first_name, :last_name].each_with_object(params) do |key, obj|
          params.require(key)
        end
        valid_params.concat([:page, movie_ids: [], images: [], videos: []])
        params.permit(valid_params)
      end
    end
  end
end
