module Api
  module V1
    class CrewsController < ApplicationController
      before_action :set_crew, only: %i[show edit update destroy]
      
      swagger_controller :crews, 'Crews'

      swagger_api :index do
        summary 'Returns all crews'
        notes 'This lists all crews'
        param :query, 'page[number]', :integer, :optional, 'Page number'
        param :query, 'page[size]', :integer, :optional, 'Page size'
        response :unauthorized
        response :not_acceptable
        response :requested_range_not_satisfiable
      end

      # GET /crews
      # GET /crews.json
      def index
        page_number = params[:page] ? params[:page][:number] : 1
        page_size = params[:page]? params[:page][:size] : Rails.application.config.default_per_page
        @crews = Crew.includes(:movies).all.page(page_number).per(page_size)
      end

      # GET /crew/1
      # GET /crew/1.json
      def show; end

      # GET /crew/new
      def new
        @crew = Crew.new
        respond_to do |format|
          if @crew
            format.json { render :show, status: :created }
          else
            format.json do
              render json: @crew.errors, status: :unprocessable_entity
            end
          end
        end
      end

      # GET /crews/1/edit
      def edit; end

      # POST /crew
      # POST /crew.json
      def create
        parameters = crew_params.dup
        parameters.delete(:images)
        parameters.delete(:videos)
        @crew = Crew.new(parameters)

        respond_to do |format|
          if @crew.save
            @crew.save_attachments(crew_params)
            format.json { render :show, status: :created }
          else
            format.json { render json: @crew.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /crew/1
      # PATCH/PUT /crew/1.json
      def update
        respond_to do |format|
          if @crew.update(crew_params)
            format.html { redirect_to @crew, notice: 'Crew was successfully updated.' }
            format.json { render :show, status: :ok, location: @crew }
          else
            format.html { render :edit }
            format.json { render json: @crew.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /crew/1
      # DELETE /crew/1.json
      def destroy
        @crew.destroy
        respond_to do |format|
          format.html { redirect_to crew_url, notice: 'Crew was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_crew
        @crew = Crew.find(params[:id]).page(1).per(1)
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def crew_params
        valid_params = Crew.attribute_names.reject do |item|
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
