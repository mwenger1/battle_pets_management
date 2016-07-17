module V1
  class BattlePetsController < ApplicationController
    before_action :set_trainer

    def index
      render json: @trainer.battle_pets
    end

    def create
      @battle_pet = BattlePet.new(merged_battle_pet_params)

      if @battle_pet.save
        render(
          json: @battle_pet,
          status: :created,
          location: v1_trainer_battle_pet_path(@trainer, @battle_pet)
        )
      else
        render json: @battle_pet.errors, status: :unprocessable_entity
      end
    end

    private

    def set_trainer
      @trainer = Trainer.where("lower(name) = ?", trainer_name).first
    end

    def trainer_name
      params.require(:trainer_name).downcase
    end

    def merged_battle_pet_params
      battle_pet_params.merge(trainer_id: @trainer.id)
    end

    def battle_pet_params
      params.require(:battle_pet).permit(
        :agility,
        :name,
        :senses,
        :strength,
        :trainer_id,
        :wit,
      )
    end
  end
end
