class Video
  include Mongoid::Document
  include Mongoid::Paperclip
  belongs_to :movie
  has_mongoid_attached_file :video
  validates_attachment_content_type :video, content_type: ['video/mp4']
  field :type, type: String, default: 'movie'
end