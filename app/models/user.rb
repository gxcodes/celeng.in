class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username,
    :uniqueness => {
      :case_sensitive => false
    }

  include Gravtastic
  gravtastic :default => "mm",
             :filetype => :jpg,
             :size => 35

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if username = conditions.delete(:username)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => username.downcase }]).first
    else
      where(conditions).first
    end
  end

  has_many :target_savings
  has_many :events

end
