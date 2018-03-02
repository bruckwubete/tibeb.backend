class Genre
  include Mongoid::Document
  has_many :movies
end
