class Poster
  include Mongoid::Document
  include Mongoid::Paperclip
  belongs_to :movie
  has_mongoid_attached_file :picture, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :picture, content_type: %w[image/jpg image/jpeg image/png image/gif]

end