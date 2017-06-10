module Api
  module V1
    class PeopleController < ApplicationController
      before_action :authenticate_user!
      before_action :set_person, only: [:show]

    

      # GET /people/1
      # GET /people/1.json
      def show
      end


      # GET /people/popular
      # GET /people/popular.json
      def popular
        @api_response = (Tmdb::Person.popular(params)).to_h
        
        @api_response[:results].each_with_index do |person, person_index|
          @api_response[:results][person_index] = person.to_h
          person[:known_for].each_with_index do |movie, index|
            person[:known_for][index] = movie.to_h
          end
        end
      end
      
      # GET /people/search/:title
      # GET /people/search.json
  
      def search
        @api_response = Tmdb::Search.person(params[:title]).to_h
        @api_response[:results].each_with_index do |movie, index|
          @api_response[:results][index] = movie.to_h
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
