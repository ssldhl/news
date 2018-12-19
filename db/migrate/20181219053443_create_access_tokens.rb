class CreateAccessTokens < ActiveRecord::Migration[5.2]
  def up
    create_table :access_tokens do |t|
      t.string :token, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :access_tokens
  end
end
