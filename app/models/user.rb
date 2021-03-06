# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string
#

class User < ActiveRecord::Base
  has_many :lists, dependent: :destroy
  has_many :items, through: :lists

  has_secure_password
  validates :username, presence: true, uniqueness: true

  def can?(action, list)
    case list.permissions
    when 'private'  then list.user == self
    when 'viewable'  then action == :view
    when 'open' then true
    else false
    end
  end
end
