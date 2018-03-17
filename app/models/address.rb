class Address
  include Mongoid::Document
  field :house_number, type: String
  field :street, type: String
  field :postal_code, type: String
  field :city, type: String
  field :country, type: String
  field :mailing_address, type: Boolean
end