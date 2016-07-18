module V1
  class IndividualBattlePetsController < ApplicationController
    ERROR_MESSAGE_404 = "record not found"

    before_action :set_battle_pet, only: [:show]

    def show
      render json: @battle_pet
    end

    private

    def set_battle_pet
      @battle_pet = BattlePet.find(battle_pet_id)
    rescue ActiveRecord::RecordNotFound
      render json: {error: ERROR_MESSAGE_404, status: 404}, status: 404
    end

    def battle_pet_id
      params.require("id")
    end
  end
end
