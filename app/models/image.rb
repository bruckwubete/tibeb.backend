class Image
  include Mongoid::Document
  include Mongoid::Paperclip
  embedded_in :actor
  embedded_in :crew
  embedded_in :director
  embedded_in :movie
  embedded_in :user
  field :model, type: String, default: 'image'

  has_mongoid_attached_file :pic, default_url: "/images/:style/:model/missing.png"
  validates_attachment_content_type :pic, content_type: %w[image/jpg image/jpeg image/png image/gif]

end