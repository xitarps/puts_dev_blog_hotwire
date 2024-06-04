class Followership < ApplicationRecord
  belongs_to :user
  belongs_to :following, class_name: 'User'
end
