class AddIndexNameForTrainers < ActiveRecord::Migration[5.0]
  def change
    add_index :trainers, :name, unique: true
  end
end
