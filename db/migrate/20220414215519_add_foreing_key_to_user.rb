class AddForeingKeyToUser < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :designs, :users
  end
end
