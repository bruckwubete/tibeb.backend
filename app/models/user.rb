class User

  include Mongoid::Document
  include Mongoid::Timestamps::Short

  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable

  include DeviseTokenAuth::Concerns::User
  include Mongoid::Paperclip

  has_mongoid_attached_file :profile_pic, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :profile_pic, content_type: %w[image/jpg image/jpeg image/png image/gif]
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  field :email, type: String
  field :name, type: String
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
