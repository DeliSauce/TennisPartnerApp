# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default("0"), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable, :omniauthable,
         :omniauth_providers => [:facebook, :twitter, :google_oauth2, :github]

  #  def self.new_with_session(params, session)
  #    super.tap do |user|
  #      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
  #        user.email = data["email"] if user.email.blank?
  #      end
      #  if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
      #    user.email = data["email"] if user.email.blank?
      #  end
      #  if data = session["devise.google_data"] && session["devise.google_data"]["extra"]["raw_info"]
      #    user.email = data["email"] if user.email.blank?
      #  end
  #    end
  #  end

   #code from facebook instructions
   def self.from_omniauth(auth)
     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.email = auth.info.email
       user.password = Devise.friendly_token[0,20]
       user.name = auth.info.name   # assuming the user model has a name
       user.image = auth.info.image # assuming the user model has an image
       user.first_name = auth.info.first_name
       user.last_name = auth.info.last_name

       # If you are using confirmable and the provider(s) you use validate emails,
       # uncomment the line below to skip the confirmation emails.
       # user.skip_confirmation!
     end
  end

  #code from google oauth2 instructions
  # def self.from_omniauth(access_token)
  #   data = access_token.info
  #   user = User.where(:email => data["email"]).first
  #
  #   # Uncomment the section below if you want users to be created if they don't exist
  #   unless user
  #       user = User.create(name: data["name"],
  #          email: data["email"],
  #          password: Devise.friendly_token[0,20]
  #       )
  #   end
  #   user
  # end
end
