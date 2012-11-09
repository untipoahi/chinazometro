class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.text :comentario

      t.references :users
      t.references :chinazos

      t.timestamps
    end
  end
end
