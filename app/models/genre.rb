class Genre
  include Mongoid::Document
  embedded_in :movie
  field :type, type: String, default: 0
end
