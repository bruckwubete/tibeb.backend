class Phonenumber
  include Mongoid::Document
  include Mongoid::Phony
  embedded_in :actor
  embedded_in :user
  embedded_in :director
  embedded_in :crew

  field :phone_number
  field :type, type: String, default: 'cell_phone'
  # Phone number
  phony_normalize :phone_number, default_country_code: 'US'
end