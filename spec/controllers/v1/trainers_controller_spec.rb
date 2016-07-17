require "rails_helper"

RSpec.describe V1::TrainersController, type: :controller do
  describe "#index" do
    it "returns all trainers with all attributes as JSON" do
      5.times { create(:trainer) }

      get :index

      expected_body = Trainer.all.to_json
      expect(response.body).to eq expected_body
    end

    it "returns 200" do
      get :index

      expect(response).to have_http_status(200)
    end
  end

  describe "#create" do
    context "trainer is valid" do
      it "creates trainer" do
        trainer_name = "Steve"
        post :create, params: permitted_params(trainer_name: trainer_name)

        expect(Trainer.all.count).to eq 1
        expect(Trainer.first.name).to eq trainer_name
      end

      it "returns 201" do
        post :create, params: permitted_params

        expect(response).to have_http_status(201)
      end

      it "returns the location of the newly created trainer" do
        post :create, params: permitted_params

        created_trainer = Trainer.first
        expect(response.location).to eq v1_trainer_url(created_trainer)
      end
    end

    context "trainer is NOT valid" do
      it "does NOT create trainer" do
        stub_invalid_trainer_for_create
        post :create, params: permitted_params

        expect(Trainer.all.count).to eq 0
      end

      it "returns 422" do
        stub_invalid_trainer_for_create
        post :create, params: permitted_params

        expect(response).to have_http_status(422)
      end
    end
  end

  describe "#show" do
    context "trainer exists" do
      it "returns provided trainer" do
        trainer = create(:trainer)

        get :show, params: { name: trainer.name }

        expect(response.body).to eq trainer.to_json
      end

      it "returns 200" do
        trainer = create(:trainer)

        get :show, params: { name: trainer.name }

        expect(response).to have_http_status(200)
      end
    end

    context "trainer does NOT exist" do
      it "returns 404" do
        non_existent_trainer_name = "nobody"

        get :show, params: { name: non_existent_trainer_name }

        expect(response).to have_http_status(404)
      end
    end
  end

  describe "#update" do
    context "trainer exists" do
      context "trainer params are valid" do
        it "updates trainer" do
          new_trainer_name = "New name"
          trainer = create(:trainer, name: "Original name")
          trainer_params = permitted_params(trainer_name: new_trainer_name)

          patch :update, params: trainer_params.merge(name: trainer.name)

          trainer.reload
          expect(trainer.name).to eq new_trainer_name
        end

        it "returns 200" do
          trainer = create(:trainer)

          patch :update, params: permitted_params.merge(name: trainer.name)

          expect(response).to have_http_status(200)
        end
      end

      context "trainer params are NOT valid" do
        it "returns 422" do
          trainer = create(:trainer)
          stub_invalid_trainer_for_update(trainer)

          patch :update, params: permitted_params.merge(name: trainer.name)

          expect(response).to have_http_status(422)
        end
      end
    end

    context "trainer does NOT exist" do
      it "returns 404" do
        non_existent_trainer_name = "nobody"

        patch :update, params: { name: non_existent_trainer_name }

        expect(response).to have_http_status(404)
      end
    end
  end

  describe "#destroy" do
    context "trainer exists" do
      it "destroys trainer" do
        trainer = create(:trainer)

        delete :destroy, params: { name: trainer.name }

        expect(Trainer.all.count).to eq 0
      end

      it "returns 204" do
        trainer = create(:trainer)

        delete :destroy, params: { name: trainer.name }

        expect(response).to have_http_status(204)
      end
    end

    context "trainer does NOT exist" do
      it "destroys trainer" do
        non_existent_trainer_name = "nobody"

        delete :destroy, params: { name: non_existent_trainer_name }

        expect(response).to have_http_status(404)
      end
    end
  end

  def permitted_params(trainer_name: "Bob")
    { trainer: { name: trainer_name, type: "type" } }
  end

  def stub_invalid_trainer_for_update(trainer)
    allow(trainer).to receive(:update).and_return(false)
    allow(Trainer).to receive(:find_by).and_return(trainer)
  end

  def stub_invalid_trainer_for_create
    invalid_trainer = double(:invalid_trainer, save: false, errors: [])
    allow(Trainer).to receive(:new).and_return(invalid_trainer)
  end
end
