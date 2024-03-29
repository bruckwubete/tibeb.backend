module Person
  extend ActiveSupport::Concern
  included do
    include Mongoid::Document
    include Mongoid::Phony
    attr_accessor :images
    attr_accessor :videos
    attr_accessor :addresses
    attr_accessor :phonenumbers

    embeds_many :images
    embeds_many :videos
    embeds_many :phonenumbers
    has_many :addresses

    # Person Info
    field :email, type: String
    field :first_name, type: String
    field :last_name, type: String
    field :nick_name, type: String
    field :bio, type: String
    field :dob, type: Date
    field :deceased, type: Boolean, default: false
    field :dod, type: Date


    ## Validations
    validates :first_name, presence: true
    validates :last_name, presence: true
  end
end