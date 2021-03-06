# == Schema Information
#
# Table name: lists
#
#  id          :integer          not null, primary key
#  name        :string
#  user_id     :integer
#  permissions :string           default("private")
#  created_at  :datetime
#  updated_at  :datetime
#

class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates :permissions, presence: true, inclusion: { in: %w(private viewable open), message: "Permissions must be set to 'private', 'viewable', or 'open'" }

  def add(item_description)
    if items.create(description: item_description)
      true
    else
      false
    end
  end

  def remove(item_description)
    if item = items.find_by(description: item_description)
      item.mark_complete
    else
      false
    end
  end
end
