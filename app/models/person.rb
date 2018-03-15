module Person
  extend ActiveSupport::Concern
  included do
    include Mongoid::Document
    attr_accessor :images
    has_many :images

    # Person Info
    field :email, type: String
    field :first_name, type: String
    field :last_name, type: String
    field :nick_name, type: String

    # Validations
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true
  end
end