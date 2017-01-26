class UserStory < ApplicationRecord
  has_many :acs, dependent: :destroy

end
