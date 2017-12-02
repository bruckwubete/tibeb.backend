require 'net/http'
require 'uri'
module Api
  module V1
    class MoviesController < ApplicationController
      #before_action :authenticate_user!
      before_action :set_movie, only: [:show, :watch]



      # GET /movies/1
      # GET /movies/1.json
      def show
      end

      # GET /movies/popular
      # GET /movies/popular.json
      def popular
        @api_response = Tmdb::Movie.popular
        @movies = []
        @api_response.results.each do |movie|
          @movies.push(movie.to_h)
        end
      end

      # GET /movies/search/:title
      # GET /movies/search.json

      def search
        @api_response = Tmdb::Search.movie(params[:title]).to_h
        @api_response[:results].each_with_index do |movie, index|
          @api_response[:results][index] = movie.to_h
        end
      end
      
       # GET /movies/discover
      # GET /movies/discover.json

      def discover
        @api_response = Tmdb::Discover.movie(params).to_h
        @api_response[:results].each_with_index do |movie, index|
          @api_response[:results][index] = movie.to_h
        end
      end
      
      # GET /movies/genres
      # GET /movies/genres.json

      def genres
        @api_response = Tmdb::Genre.movie_list
        @api_response.each_with_index do |genre, index|
          @api_response[index] = genre.to_h
        end
      end
      
      def watch
        uri = URI.parse("https://api.apidomain.info/movie?imdb=" + @movie[:imdb_id])
        puts uri.to_s
        request = Net::HTTP::Get.new(uri)
        #request.basic_auth("bruckwendu80@gmail.com", "Myseedr%5")
        
        req_options = {
          use_ssl: uri.scheme == "https",
        }
        
        items_response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          response = http.request(request)
          if response.code != 200.to_s
            render :json => @movie and return 
          end
          JSON.parse response.body
        end
        
        downloaded_folder = nil 
        uri = URI.parse("https://www.seedr.cc/rest/folder")
        request = Net::HTTP::Get.new(uri)
        request.basic_auth("bruckwendu80@gmail.com", "Myseedr%5")
        
        req_options = {
          use_ssl: uri.scheme == "https",
        }
        
        folders_response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          JSON.parse http.request(request).body
        end
        
        puts folders_response
        
        downloaded_folder = folders_response['folders'].detect{|f|
          puts ['items'][0]['file']
          items_response['items'][0]['file'].include? f['name'] 
        }
        
        
        
        if not downloaded_folder
          uri = URI.parse("https://www.seedr.cc/rest/torrent/magnet")
          request = Net::HTTP::Post.new(uri)
          request.basic_auth("bruckwendu80@gmail.com", "Myseedr%5")
          request.set_form_data(
            "magnet" => items_response['items'][0]['torrent_magnet'],
          )
          
          req_options = {
            use_ssl: uri.scheme == "https",
          }
          
          magnet_response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
           JSON.parse http.request(request).body
          end
          
          index = 0
          while not downloaded_folder and index < 5 do
            uri = URI.parse("https://www.seedr.cc/rest/folder")
            request = Net::HTTP::Get.new(uri)
            request.basic_auth("bruckwendu80@gmail.com", "Myseedr%5")
            
            req_options = {
              use_ssl: uri.scheme == "https",
            }
            
            folders_response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
              JSON.parse http.request(request).body
            end
            
            downloaded_folder = folders_response['folders'].detect{|f|
              puts f['name']
              puts magnet_response['title']
              f['name'].include? magnet_response['title']
            }
            
            sleep 3
            index = index + 1
          end
        end
        
        puts downloaded_folder
          
        uri = URI.parse("https://www.seedr.cc/rest/folder/" + downloaded_folder['id'].to_s)
        request = Net::HTTP::Get.new(uri)
        request.basic_auth("bruckwendu80@gmail.com", "Myseedr%5")
        
        req_options = {
          use_ssl: uri.scheme == "https",
        }
        
        files_response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
         JSON.parse http.request(request).body
        end
        

        
        downloaded_file = files_response['files'].detect{|f| f['name'].include? items_response['items'][0]['file']}
        
                
        uri = URI.parse("https://www.seedr.cc/rest/file/" + downloaded_file['id'].to_s + '/hls')
        request = Net::HTTP::Get.new(uri)
        request.basic_auth("bruckwendu80@gmail.com", "Myseedr%5")
        
        req_options = {
          use_ssl: uri.scheme == "https",
        }
        
        hls_response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end
          
         @movie[:hls] = hls_response['location']
        
      end



      private
        # Use callbacks to share common setup or constraints between actions.
      def set_movie
        begin
          @movie = Tmdb::Movie.detail(params[:id].to_i).to_h
          get_more_info params[:id].to_i
          toHash = [:genres, :production_companies, :production_countries, :spoken_languages, :cast, :crew, :director, :videos]
          toHash.each do |prop|
            convert_to_hash prop
          end
        rescue Tmdb::Error => e
          @movie = []
        end
      end

      def get_more_info id
        begin
          crew =  Tmdb::Movie.crew(id)
          @movie[:crew] = crew

          cast =  Tmdb::Movie.cast(id)
          @movie[:cast] = cast

          director =  Tmdb::Movie.director(id)
          @movie[:director] = director

          videos =  Tmdb::Movie.videos(id)
          @movie[:videos] = videos

        rescue Tmdb::Error => e
          puts e
        end
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def movie_params
        params.fetch(:movie, {})
      end

      def convert_to_hash prop
        @movie[prop].each_with_index do |item, index|
          @movie[prop][index] = item.to_h
        end
      end
    end
  end
end
