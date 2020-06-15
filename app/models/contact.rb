class Contact < ApplicationRecord
  
  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP}

  def friendly_updated_at
    updated_at.strftime("%A, %d %b %Y %l:%M %p")
  end

  def full_name
    full_name = first_name + " " + middle_name + " " + last_name
    
    full_name
  end

  def japanese_prefix
    prefix = "+81 #{phone_number}"
    prefix
  end

  belongs_to :user

  has_many :contact_groups
  has_many :groups, through: :contact_groups
end
