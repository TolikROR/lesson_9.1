class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      if auth.info.email == nil
        user.email = 'default_emaul@gmail.com'
      end
      user.password = Devise.friendly_token[0,20]

      #user.first_name = "facebook_firs_name_#{auth.uid}"
      #user.last_name = "facebook_firs_name_#{auth.uid}"
      binding.pry
    end
  end
end

