class AddForeingKeyCommentAndAnswer < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :comments, :designs
    add_foreign_key :answers, :comments
  end
end
