class Actor
  include Person
  include Mongoid::Document
  has_and_belongs_to_many :movies

  ## Validations
  validates :email, presence: false, uniqueness: false
end
