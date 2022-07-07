class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.string :user
      t.integer :comment
      t.string :answer

      t.timestamps
    end
  end
end
