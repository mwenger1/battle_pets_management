class RemoveTypeFromTrainers < ActiveRecord::Migration[5.0]
  def change
    remove_column :trainers, :type, :string
  end
end
