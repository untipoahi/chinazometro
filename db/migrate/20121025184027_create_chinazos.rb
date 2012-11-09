class CreateChinazos < ActiveRecord::Migration
  def change
    create_table :chinazos do |t|
      t.string :nombre
      t.text :descripcion

      t.references :users
      t.timestamps
    end
  end
end
