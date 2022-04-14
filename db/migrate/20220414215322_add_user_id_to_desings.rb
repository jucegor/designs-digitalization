class AddUserIdToDesings < ActiveRecord::Migration[6.0]
  def change
    add_column :designs, :user_id, :integer
  end
end
