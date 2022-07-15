class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :project_number_req
      t.string :project_name_req
      t.date :required_date
      t.date :delivered
      t.string :status
      t.references :design, null: true, foreign_key: true

      t.timestamps
    end
  end
end
