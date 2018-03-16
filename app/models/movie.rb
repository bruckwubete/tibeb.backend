class Movie
  include Mongoid::Document
  paginates_per 5
  attr_accessor :images
  attr_accessor :videos
  attr_accessor :genres
  attr_accessor :actors
  attr_accessor :directors
  attr_accessor :crews

  has_many :images
  has_many :videos
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :actors
  has_and_belongs_to_many :directors
  has_and_belongs_to_many :crews

  field :adult, type: Boolean, default: false
  field :budget, type: Float, default: 0
  field :homepage, type: String, default: ''
  field :overview, type: String, default: ''
  field :popularity, type: Integer, default: 0
  field :release_date, type: Time, default: Time.now
  field :runtime, type: Integer, default: 0
  field :status, type: String, default: ''
  field :title, type: String, default: ''
  field :vote_average, type: Float, default: 0
  field :vote_count, type: Integer, default: 0

  def save_attachments(params)
    params[:posters].each { |pic| images.create(pic: pic) } if params[:posters]
    params[:videos].each { |vid| videos.create(video: vid) } if params[:videos]
    Helpers.find_genres(self, params)
    Helpers.create_or_find_actors(self, params)
    # params[:directors].each { |director| actors.create(director) } if params[:directors]
    # params[:crews].each { |crew| actors.create(crew) } if params[:crews]
  end

  module Helpers
    extend MoviesHelper
  end
end
