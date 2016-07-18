require "rails_helper"

RSpec.describe V1::IndividualBattlePetsController, type: :controller do
  describe "#show" do
    context "battle_pet exists" do
      it "returns provided battle_pet" do
        battle_pet = create(:battle_pet)

        get :show, params: { id: battle_pet.id }

        expect(response.body).to eq battle_pet.to_json
      end

      it "returns 200" do
        battle_pet = create(:battle_pet)

        get :show, params: { id: battle_pet.id }

        expect(response).to have_http_status(200)
      end
    end

    context "battle_pet does NOT exist" do
      it "returns 404" do
        non_existent_battle_pet_id = 1

        get :show, params: { id: non_existent_battle_pet_id }

        expect(response).to have_http_status(404)
      end
    end
  end
end
