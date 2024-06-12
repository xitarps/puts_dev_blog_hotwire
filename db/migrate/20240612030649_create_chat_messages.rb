class CreateChatMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_messages, id: :uuid do |t|
      t.references :chat, null: false, foreign_key: true, type: :uuid
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.text :message

      t.timestamps
    end
  end
end
