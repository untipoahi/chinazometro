class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value
      t.references :users
      t.references :chinazos

      t.timestamps
    end 
    add_index :votes, :users_id
    add_index :votes, :chinazos_id
  end
end