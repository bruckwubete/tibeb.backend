class Actor
  include Person
  include Mongoid::Document
  has_and_belongs_to_many :movies
  #accepts_nested_attributes_for :phonenumbers
  ## Validations
  validates :email, presence: false, uniqueness: false


  def save_phone_number(phone_number)
    phonenumbers.create(phone_number: phone_number[:phone_number]) if phone_number &&  phone_number[:phone_number]
  end

  def save_image()
    images.create(model: 'actor')
  end
end
