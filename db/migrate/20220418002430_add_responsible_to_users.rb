class AddResponsibleToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :responsible, :string
  end
end
