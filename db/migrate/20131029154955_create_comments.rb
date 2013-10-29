class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.integer :link_id
      t.integer :score

      t.timestamps
    end
  end
end
