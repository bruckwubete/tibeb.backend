class Image
  include Mongoid::Document
  include Mongoid::Paperclip
  belongs_to :person
  has_mongoid_attached_file :pic, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :pic, content_type: %w[image/jpg image/jpeg image/png image/gif]

end