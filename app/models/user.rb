class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events
  enum role: [:standard, :premium, :admin]

  after_initialize do
    if self.new_record?
     self.role ||= :standard
    end
  end

end
