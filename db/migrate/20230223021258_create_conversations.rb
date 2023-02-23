class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.references :recipient, index: true, foreign_key: { to_table: :users }
      t.references :sender,    index: true, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
