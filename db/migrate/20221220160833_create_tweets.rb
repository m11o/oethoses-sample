class CreateTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quote_tweet, null: true, foreign_key: { to_table: :tweets }
      t.text :content, null: false

      t.timestamps
    end
  end
end
