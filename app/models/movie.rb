class Movie
  include Mongoid::Document
  include Mongoid::Paperclip

  has_mongoid_attached_file :picture, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

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
end
