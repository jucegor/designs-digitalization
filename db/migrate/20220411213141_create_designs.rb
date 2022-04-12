class CreateDesigns < ActiveRecord::Migration[6.0]
  def change
    create_table :designs do |t|
      t.string :project_number
      t.string :client
      t.string :project_name
      t.string :responsable
      t.integer :revision
      t.string :line
      t.string :status
      t.string :autodesk_link
      t.string :server_path

      t.timestamps
    end
  end
end
