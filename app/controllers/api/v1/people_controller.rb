module Api
  module V1
    class PeopleController < ApplicationController
      before_action :authenticate_user!
      before_action :set_person, only: [:show, :edit, :update, :destroy]

      # GET /people
      # GET /people.json
      def index
      end

      # GET /people/1
      # GET /people/1.json
    def show
    end

    # GET /people/new
    def new
      @person = Person.new
    end

    # GET /people/1/edit
    def edit
    end

    # POST /people
    # POST /people.json
    def create
      @person = Person.new(person_params)

      respond_to do |format|
        if @person.save
          format.html { redirect_to @person, notice: 'Person was successfully created.' }
          format.json { render :show, status: :created, location: @person }
        else
          format.html { render :new }
          format.json { render json: @person.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /people/1
    # PATCH/PUT /people/1.json
    def update
      respond_to do |format|
        if @person.update(person_params)
          format.html { redirect_to @person, notice: 'Person was successfully updated.' }
          format.json { render :show, status: :ok, location: @person }
        else
          format.html { render :edit }
          format.json { render json: @person.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /people/1
    # DELETE /people/1.json
    def destroy
      @person.destroy
      respond_to do |format|
        format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    # GET /people/popular
    # GET /people/popular.json
    def popular
      @api_response = Tmdb::Person.popular
      @people = []
      @api_response.results.each do |person|
        person[:known_for].each_with_index do |movie, index|
          person[:known_for][index] = movie.to_h
        end
        @people.push(person.to_h)
      end
    end
    

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_person
         begin
           @person = Tmdb::Person.detail(params[:id].to_i).to_h
           get_more_info params[:id].to_i
           toHash = [:movie_credits, :tv_credits]
           toHash.each do |prop|
             convert_to_hash prop
           end
         rescue Tmdb::Error => e
           @person = []
         end
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def person_params
        params.permit(:id)
      end

      def get_more_info id
        begin
          cast_n_crew =  Tmdb::Person.movie_credits(id).to_h
          @person[:movie_credits] = cast_n_crew

          cast_n_crew =  Tmdb::Person.tv_credits(id).to_h
          @person[:tv_credits] = cast_n_crew

        rescue Tmdb::Error => e
          puts e
        end
      end

      def convert_to_hash prop
        @person[prop][:cast].each_with_index do |item, index|
          @person[prop][:cast][index] = item.to_h
        end
        @person[prop][:crew].each_with_index do |item, index|
          @person[prop][:crew][index] = item.to_h
        end
      end
    end
  end
end
