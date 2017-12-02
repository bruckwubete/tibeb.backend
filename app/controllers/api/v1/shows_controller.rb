module Api
  module V1
    class ShowsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_show, only: [:show]


      # GET /shows/1
      # GET /shows/1.json
      def show
        puts @show
        
      end

      # GET /people/popular
      # GET /people/popular.json
      def popular
        @api_response = Tmdb::TV.popular
        @shows = []
        @api_response.results.each do |show|
          @shows.push(show.to_h)
        end
      end
  
      # GET /shows/search/:title
      # GET /shows/search.json

      def search
        @api_response = Tmdb::Search.tv(params[:title]).to_h
        @api_response[:results].each_with_index do |movie, index|
          @api_response[:results][index] = movie.to_h
        end
      end
      
       # GET /movies/discover
      # GET /movies/discover.json

      def discover
        puts params
        @api_response = Tmdb::Discover.tv(params).to_h
        @api_response[:results].each_with_index do |movie, index|
          @api_response[:results][index] = movie.to_h
        end
      end
      
      # GET /movies/genres
      # GET /movies/genres.json

      def genres
        @api_response = Tmdb::Genre.tv_list
        @api_response.each_with_index do |genre, index|
          @api_response[index] = genre.to_h
        end
      end


    private
      # Use callbacks to share common setup or constraints between actions.
      def set_show
        begin
          @show = Tmdb::TV.detail(params[:id].to_i).to_h
          get_more_info params[:id].to_i
          toHash = [:created_by, :networks, :seasons, :genres, :production_companies, :cast, :crew, :videos]
          toHash.each do |prop|
            convert_to_hash prop
          end
        rescue Tmdb::Error => e
          @show = []
        end
      end

      def get_more_info id
        begin
          crew =  Tmdb::TV.crew(id)
          @show[:crew] = crew

          cast =  Tmdb::TV.cast(id)
          @show[:cast] = cast

          videos =  Tmdb::TV.videos(id)
          @show[:videos] = videos

        rescue Tmdb::Error => e
          puts e
        end
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def show_params
        params.fetch(:show, {})
      end

      def convert_to_hash prop
        @show[prop].each_with_index do |item, index|
          @show[prop][index] = item.to_h
        end
      end
    end
  end
end
