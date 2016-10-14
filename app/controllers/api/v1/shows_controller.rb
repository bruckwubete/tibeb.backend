module Api
  module V1
    class ShowsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_show, only: [:show, :edit, :update, :destroy]

      # GET /shows
      # GET /shows.json
      def index
        @shows = Show.all
      end

      # GET /shows/1
      # GET /shows/1.json
      def show
      end

      # GET /shows/new
      def new
        @show = Show.new
      end

      # GET /shows/1/edit
      def edit
      end

      # POST /shows
      # POST /shows.json
    def create
      @show = Show.new(show_params)

      respond_to do |format|
        if @show.save
          format.html { redirect_to @show, notice: 'Show was successfully created.' }
          format.json { render :show, status: :created, location: @show }
        else
          format.html { render :new }
          format.json { render json: @show.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /shows/1
    # PATCH/PUT /shows/1.json
    def update
      respond_to do |format|
        if @show.update(show_params)
          format.html { redirect_to @show, notice: 'Show was successfully updated.' }
          format.json { render :show, status: :ok, location: @show }
        else
          format.html { render :edit }
          format.json { render json: @show.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /shows/1
    # DELETE /shows/1.json
    def destroy
      @show.destroy
      respond_to do |format|
        format.html { redirect_to shows_url, notice: 'Show was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    # GET /people/popular
    # GET /people/popular.json
    def popular
      @api_response = Tmdb::Discover.tv
      @shows = []
      @api_response.results.each do |show|
        @shows.push(show.to_h)
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
