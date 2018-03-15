class Genre
  include Mongoid::Document
  has_and_belongs_to_many :movies
  field :type, type: String, default: 0

  validates :type, uniqueness: true, presence: true
end
