class ChangeName < ActiveRecord::Migration[6.0]
  def change
    rename_column :answers, :comment, :comment_id
    rename_column :comments, :design, :design_id
  end
end
