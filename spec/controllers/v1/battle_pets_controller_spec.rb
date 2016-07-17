require 'rails_helper'

RSpec.describe V1::BattlePetsController, type: :controller do
  describe "#index" do
    it "returns all trainer's battle_pets as JSON" do
      trainer = create(:trainer)
      different_trainer = create(:trainer)
      create(:battle_pet, trainer: trainer)
      create(:battle_pet, trainer: different_trainer)

      get :index, params: { trainer_name: trainer.name }

      expect(response.body).to eq trainer.battle_pets.to_json
    end
  end

  describe "#create" do
    context "battle_pet is valid" do
      it "creates a battle_pet" do
        trainer = create(:trainer)

        post(
          :create,
          params: battle_pet_params.merge(trainer_name: trainer.name)
        )

        battle_pets = trainer.battle_pets
        expect(battle_pets.count).to eq 1
        expect(battle_pets.first.name).to eq "Pikachu"
      end

      it "returns 201" do
        trainer = create(:trainer)

        post(
          :create,
          params: battle_pet_params.merge(trainer_name: trainer.name)
        )

        expect(response).to have_http_status(201)
      end

      it "returns the location of the newly created battle pet" do
        trainer = create(:trainer)

        post(
          :create,
          params: battle_pet_params.merge(trainer_name: trainer.name)
        )

        battle_pet = BattlePet.first
        expect(response.location).
          to eq v1_trainer_battle_pet_path(trainer, battle_pet)
      end
    end

    context "battle_pet is NOT valid" do
      it "does NOT create battle pet" do
        trainer = create(:trainer)
        stub_invalid_battle_pet_for_create

        post(
          :create,
          params: battle_pet_params.merge(trainer_name: trainer.name)
        )

        expect(BattlePet.all.count).to eq 0
      end

      it "returns 422" do
        trainer = create(:trainer)
        stub_invalid_battle_pet_for_create


        post(
          :create,
          params: battle_pet_params.merge(trainer_name: trainer.name)
        )

        expect(response).to have_http_status(422)
      end
    end
  end

  def battle_pet_params
    { battle_pet: { name: "Pikachu", strength: 1, wit: 1, senses: 1, agility: 1 } }
  end

  def stub_invalid_battle_pet_for_create
    invalid_battle_pet = double(:invalid_battle_pet, save: false, errors: [])
    allow(BattlePet).to receive(:new).and_return(invalid_battle_pet)
  end
end
