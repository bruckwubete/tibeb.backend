class User
  include Person
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  #store_in collection: "users"

  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable

  include DeviseTokenAuth::Concerns::User
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
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


  ## unique oauth id
  field :provider, type: String
  field :uid, default: ''

  ## Tokens
  field :tokens, type: Hash, default: { }

  ## Custom additional fields
  field :terms, type: Boolean, default: false
  field :confirm_success_url, type: String

  ## Index
  index({email: 1, uid: 1, reset_password_token: 1}, unique: true)

  ## Validations
  validates :email, presence: true, uniqueness: true
  validates :uid, uniqueness: true

  def save_profile_pics(params)
    params[:profile_pic].each { |pic| images.create(pic: pic[1], model: 'user') }
  end
end
