class ChatMessage < ApplicationRecord
  belongs_to :chat
  belongs_to :sender, class_name: 'User'
end
