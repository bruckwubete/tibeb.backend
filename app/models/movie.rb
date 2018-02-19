class Movie
  include Mongoid::Document
  paginates_per 5
  attr_accessor :posters
  attr_accessor :videos
  has_many :posters
  has_many :videos

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
    params[:posters].each { |pic| posters.create(picture: pic) } if params[:posters]
    params[:videos].each { |vid| videos.create(video: vid) } if params[:videos]
  end
end
