class CreateBattlePets < ActiveRecord::Migration[5.0]
  def change
    create_table :battle_pets do |t|
      t.string :name
      t.integer :strength
      t.integer :agility
      t.integer :wit
      t.integer :senses

      t.timestamps
    end

    add_reference :battle_pets, :trainer, index: true, foreign_key: true
  end
end
