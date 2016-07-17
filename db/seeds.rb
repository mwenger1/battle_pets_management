# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
trainer = Trainer.create(name: "Ash Ketchum")

BattlePet.create(name: "Pikachu", trainer: trainer)
BattlePet.create(name: "Charizard", trainer: trainer)
BattlePet.create(name: "Squirtle", trainer: trainer)
