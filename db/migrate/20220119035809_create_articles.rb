# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[7.0]
  def up
    create_table :articles do |t|
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps
    end

    safety_assured do
      execute <<-SQL.squish
        CREATE INDEX articles_body_index ON articles(lower(body))
      SQL
    end
  end

  def down
    drop_table :articles
  end
end
