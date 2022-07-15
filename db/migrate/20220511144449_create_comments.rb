class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :design
      t.string :user
      t.string :comment
      t.string :hcc
      t.references :design, foreign_key: true, index: true
      t.timestamps
    end
  end
end
