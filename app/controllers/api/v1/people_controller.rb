module Api
  module V1
    class PeopleController < ApplicationController
      before_action :set_People, only: %i[show edit update destroy]

      # GET /People
      # GET /People.json
      def index
        @People = People.all
      end

      # GET /People/1
      # GET /People/1.json
      def show; end

      # GET /People/new
      def new
        @Person = People.new
      end

      # GET /People/1/edit
      def edit; end

      # People /People
      # People /People.json
      def create
        @Person = People.new(People_params)

        respond_to do |format|
          if @People.save
            format.html { redirect_to @Person, notice: '@Person was successfully created.' }
            format.json { render :show, status: :created, location: @Person }
          else
            format.html { render :new }
            format.json { render json: @Person.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /People/1
      # PATCH/PUT /People/1.json
      def update
        respond_to do |format|
          if @Person.update(People_params)
            format.html { redirect_to @Person, notice: 'Person was successfully updated.' }
            format.json { render :show, status: :ok, location: @Person }
          else
            format.html { render :edit }
            format.json { render json: @Person.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /People/1
      # DELETE /People/1.json
      def destroy
        @Person.destroy
        respond_to do |format|
          format.html { redirect_to Person_url, notice: 'Person was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_People
        @Person = People.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def People_params
        params.require(:People).permit(:name, :title, :content)
      end
    end
  end
end
