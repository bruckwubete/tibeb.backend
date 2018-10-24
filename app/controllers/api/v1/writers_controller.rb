module Api
  module V1
    class WritersController < ApplicationController
      before_action :set_writer, only: %i[show edit update destroy]
      
      swagger_controller :writers, 'Writers'

      swagger_api :index do
        summary 'Returns all writers'
        notes 'This lists all writers'
        param :query, 'page[number]', :integer, :optional, 'Page number'
        param :query, 'page[size]', :integer, :optional, 'Page size'
        response :unauthorized
        response :not_acceptable
        response :requested_range_not_satisfiable
      end

      # GET /writers
      # GET /writers.json
      def index
        page_number = params[:page] ? params[:page][:number] : 1
        page_size = params[:page]? params[:page][:size] : Rails.application.config.default_per_page
        @writers = Writer.includes(:movies).all.page(page_number).per(page_size)
      end

      # GET /writer/1
      # GET /writer/1.json
      def show; end

      # GET /writer/new
      def new
        @writer = Writer.new
        respond_to do |format|
          if @writer
            format.json { render :show, status: :created }
          else
            format.json do
              render json: @writer.errors, status: :unprocessable_entity
            end
          end
        end
      end

      # GET /writers/1/edit
      def edit; end

      # POST /writer
      # POST /writer.json
      def create
        parameters = writer_params.dup
        parameters.delete(:images)
        parameters.delete(:videos)
        @writer = Writer.new(parameters)

        respond_to do |format|
          if @writer.save
            @writer.save_attachments(writer_params)
            format.json { render :show, status: :created }
          else
            format.json { render json: @writer.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /writer/1
      # PATCH/PUT /writer/1.json
      def update
        respond_to do |format|
          if @writer.update(writer_params)
            format.html { redirect_to @writer, notice: 'Writer was successfully updated.' }
            format.json { render :show, status: :ok, location: @writer }
          else
            format.html { render :edit }
            format.json { render json: @writer.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /writer/1
      # DELETE /writer/1.json
      def destroy
        @writer.destroy
        respond_to do |format|
          format.html { redirect_to writer_url, notice: 'Writer was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_writer
        @writer = Writer.find(params[:id]).page(1).per(1)
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def writer_params
        valid_params = Writer.attribute_names.reject do |item|
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
