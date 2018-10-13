class Crew
  include Person
  include Mongoid::Document
  paginates_per 5
  has_and_belongs_to_many :movies
 
  ## Validations
  validates :email, presence: false, uniqueness: false
  
  field :retired, type: Boolean, default: false


  def save_phone_number(phone_number)
    phonenumbers.create(phone_number: phone_number[:phone_number]) if phone_number &&  phone_number[:phone_number]
  end

  def save_image()
    images.create(model: 'crew') if images.empty?
  end
  
  def save_videos()
    videos.create(model: 'crew') if videos.empty?
  end
  
  def save_attachments(params)
    if params[:pictures]
      params[:pictures].each { |pic| images.create(pic: pic, model: 'crew') }
    else
      save_image
    end
    if params[:videos]
      params[:videos].each { |vid| videos.create(video: vid,  model: 'crew') }
    else
      save_videos
    end
  end
end
