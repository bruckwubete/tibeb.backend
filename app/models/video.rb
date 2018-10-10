class Video
  include Mongoid::Document
  include Mongoid::Paperclip
  embedded_in :actor
  embedded_in :crew
  embedded_in :director
  embedded_in :movie
  embedded_in :user
  field :model, type: String, default: 'video'
  
  has_mongoid_attached_file :video
  validates_attachment_content_type :video, content_type: ['video/mp4']
end