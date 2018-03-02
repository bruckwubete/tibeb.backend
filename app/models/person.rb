class Person
  include Mongoid::Document
  attr_accessor :images
  has_many :images
end
