class RenameResponsableToResponsibleInDesigns < ActiveRecord::Migration[6.0]
  def change
    rename_column :designs, :responsable, :responsible
  end
end
