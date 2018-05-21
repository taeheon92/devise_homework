class User < ActiveRecord::Base

    rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(student_id) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:student_id) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
    end
end
