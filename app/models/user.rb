# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, presence: true

  include DeviseTokenAuth::Concerns::User

  has_many :user_orgs
  has_many :orgs, through: :user_orgs

  def as_json(_options = {})
    { id: id,
      first_name: first_name,
      last_name: last_name,
      email: email }
  end

  # def as_a(role)
  #   role = Role.find_by(name: role.downcase) if role.class == String
  #   user_roles.find_by(role: role)
  # end

  def self.first_or_initialize_for_google(data)
    where(uid: data['email']).first_or_initialize.tap do |user|
      user.provider = 'google'
      user.uid = data['email']
      user.email = data['email']
      user.first_name = data['given_name']
      user.last_name = data['family_name']
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.first_or_initialize_for_facebook(email, name)
    where(uid: email).first_or_initialize.tap do |user|
      user.provider = 'facebook'
      user.uid = email
      user.email = email
      user.first_name = name.split.first
      user.last_name = name.split.last
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
