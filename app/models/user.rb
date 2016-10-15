class User
    # Get rid of devise-token_auth issues from activerecord
  def self.table_exists?
    true
  end

  def self.columns_hash
    # Just fake it for devise-token-auth; since this model is schema-less, this method is not really useful otherwise
    {} # An empty hash, so tokens_has_json_column_type will return false, which is probably what you want for Monogoid/BSON
  end

  def self.serialize(*args)

  end
    include Mongoid::Document
  include Mongoid::Timestamps::Short
  include DeviseTokenAuth::Concerns::User

  def self.send_on_create_confirmation_instructions

end

 before_validation do
    self.password = email if password.blank?
 end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

    field :email, type: String
  field :encrypted_password, type: String, default: ''

  ## Recoverable
  field :reset_password_token, type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count, type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at, type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String

  ## Confirmable
  field :confirmation_token, type: String
  field :confirmed_at, type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email, type: String

  ## User Info
  field :name, type: String
  field :nickname, type: String
  field :image, type: String

  ## unique oauth id
  field :provider, type: String
  field :uid, default: ""

  ## Tokens
  field :tokens, type: Hash, default: { }

  ## Index
  index({email: 1, uid: 1, reset_password_token: 1}, {unique: true})

  ## Validation
  validates_uniqueness_of :email, :uid
end
