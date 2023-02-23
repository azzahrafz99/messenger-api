class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :conversation
      t.references :sender, index: true, foreign_key: { to_table: :users }
      t.text       :message
      t.datetime   :read_at
      t.timestamps
    end
  end
end
