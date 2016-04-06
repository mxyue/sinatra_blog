class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
        t.string :content
        t.string :pictures
        t.timestamps null: false

        t.references :user, index: true
    end
  end
end
