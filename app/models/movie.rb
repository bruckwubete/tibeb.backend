class Movie
  include Mongoid::Document
  paginates_per Rails.configuration.default_per_page
  attr_accessor :images
  attr_accessor :videos
  attr_accessor :genres
  attr_accessor :actors
  attr_accessor :directors
  attr_accessor :crews
  attr_accessor :writers

  embeds_many :images
  embeds_many :videos
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :actors
  has_and_belongs_to_many :directors
  has_and_belongs_to_many :crews
  has_and_belongs_to_many :writers

  field :adult, type: Boolean, default: false
  field :backdrop_path, type: String, default: ''
  field :belongs_to_collection, type: Boolean, default: false
  field :budget, type: Float, default: 0.0
  field :homepage, type: String, default: ''
  field :imdb_id, type: String, default: ''
  field :original_language, type: String, default: 'en'
  field :original_title, type: String, default: ''
  field :overview, type: String, default: ''
  field :popularity, type: Integer, default: 0
  field :poster_path, type: String, default: ''
  field :release_date, type: Time, default: Time.now
  field :revenue, type: Float, default: 0.0
  field :runtime, type: Integer, default: 0
  field :status, type: String, default: ''
  field :tagline, type: String, default: ''
  field :title, type: String, default: ''
  field :video, type: Boolean, default: false
  field :vote_average, type: Float, default: 0.0
  field :vote_count, type: Integer, default: 0.0
  
  # before_save :save

  # def save_attachments(params)
  #   params[:posters].each { |pic| images.create(pic: pic, model: 'movie') } if params[:posters]
  #   params[:videos].each { |vid| videos.create(video: vid, model: 'movie') } if params[:videos]
  #   Helpers.find_genres(self, params)
  #   Helpers.create_or_find_actors(self, params)
  #   # params[:directors].each { |director| actors.create(director) } if params[:directors]
  #   # params[:crews].each { |crew| actors.create(crew) } if params[:crews]
  # end


  def save_image()
    images.create(model: 'movie') if images.empty?
  end
  
  def save_videos()
    videos.create(model: 'movie') if videos.empty?
  end
  
  def save_attachments(params)
    if params[:images]
      params[:images].each { |pic| images.create(pic: pic, model: 'movie') }
    else
      save_image
    end
    if params[:videos]
      params[:videos].each { |vid| videos.create(video: vid, model: 'movie') }
    else
      save_videos
    end
    if params[:genres]
       params[:genres].each { |genre_id| 
          gn = Genre.find_by(id: genre_id)
          genres <<  gn unless genre_ids.include?(genre_id)
       }
    else
    end
    Helpers.create_or_find_movie_attributes(self, params)
  end
  
  module Helpers
    extend MoviesHelper
  end
end
