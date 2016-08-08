class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.string :city
      t.integer :num
      t.string :website
      t.date :query_date

      t.timestamps null: false
    end
  end
end
