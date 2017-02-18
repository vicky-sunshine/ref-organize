class CreatePapers < ActiveRecord::Migration[5.0]
  def change
    create_table :papers do |t|
      t.string :doi
      t.string :url
      t.string :title
      t.string :author
      t.string :book_title
      t.string :publisher
      t.integer :volume
      t.integer :issue
      t.string :pages
      t.integer :year
      t.integer :month
      t.string :bibtex
      t.text :note

      t.timestamps
    end
  end
end
