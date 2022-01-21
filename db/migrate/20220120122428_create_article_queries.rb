# frozen_string_literal: true

class CreateArticleQueries < ActiveRecord::Migration[7.0]
  def change
    create_table :article_queries do |t|
      t.string :body, null: false
      t.string :user_id, null: false

      t.timestamps
    end

    add_index :article_queries, :body
    add_index :article_queries, :user_id
    add_index :article_queries, [:created_at, :user_id], unique: true
  end
end
