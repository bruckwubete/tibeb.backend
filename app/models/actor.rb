class Actor
  include Person
  include Mongoid::Document
  after_create :save_image
  paginates_per 5
  has_and_belongs_to_many :movies
 
  ## Validations
  validates :email, presence: false, uniqueness: false
  
  field :retired, type: Boolean, default: false


  def save_phone_number(phone_number)
    phonenumbers.create(phone_number: phone_number[:phone_number]) if phone_number &&  phone_number[:phone_number]
  end

  def save_image()
    images.create(model: 'actor') if images.nil?
  end
  
  def save_attachments(params)
    params[:pictures].each { |pic| images.create(pic: pic, model: 'actor') } if params[:pictures]
    params[:videos].each { |vid| videos.create(video: vid) } if params[:videos]
  end
end
