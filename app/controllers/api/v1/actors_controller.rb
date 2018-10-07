module Api
  module V1
    class ActorsController < ApplicationController
      before_action :set_actor, only: %i[show edit update destroy]

      # GET /actors
      # GET /actors.json
      def index
        page_number = params[:page] ? params[:page][:number] : 1
        page_size = params[:page]? params[:page][:size] : Rails.application.config.default_per_page
        @actors = Actor.includes(:movies).all.page(page_number).per(page_size)
      end

      # GET /actor/1
      # GET /actor/1.json
      def show; end

      # GET /actor/new
      def new
        @actor = Actor.new
        respond_to do |format|
          if @actor
            format.json { render :show, status: :created }
          else
            format.json do
              render json: @actor.errors, status: :unprocessable_entity
            end
          end
        end
      end

      # GET /actors/1/edit
      def edit; end

      # POST /actor
      # POST /actor.json
      def create
        parameters = actor_params.dup
        parameters.delete(:pictures)
        @actor = Actor.new(parameters)

        respond_to do |format|
          if @actor.save
            @actor.save_attachments(actor_params)
            format.json { render :show, status: :created }
          else
            format.json { render json: @actor.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /actor/1
      # PATCH/PUT /actor/1.json
      def update
        respond_to do |format|
          if @actor.update(actor_params)
            format.html { redirect_to @actor, notice: 'Actor was successfully updated.' }
            format.json { render :show, status: :ok, location: @actor }
          else
            format.html { render :edit }
            format.json { render json: @actor.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /actor/1
      # DELETE /actor/1.json
      def destroy
        @actor.destroy
        respond_to do |format|
          format.html { redirect_to actor_url, notice: 'Actor was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_actor
        @actor = Actor.find(params[:id]).page(1).per(1)
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def actor_params
        valid_params = Actor.attribute_names.reject do |item|
          item.match(/^_id/)
        end
        [:first_name, :last_name].each_with_object(params) do |key, obj|
          params.require(key)
        end
        valid_params.concat([:page, movie_ids: [], pictures: []])
        params.permit(valid_params)
      end
    end
  end
end
