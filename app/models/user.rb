class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :writing_sessions
  after_create :subscribe_to_mailing

  private

  def subscribe_to_mailing
    MailerLite.create_group_subscriber(107870239, { email: email })
  end
end
