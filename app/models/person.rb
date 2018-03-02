module Person
  extend ActiveSupport::Concern
  included do
    include Mongoid::Document
    attr_accessor :images
    has_many :images
    field :fans
  end
end