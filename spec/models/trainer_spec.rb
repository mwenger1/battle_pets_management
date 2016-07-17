require "rails_helper"

RSpec.describe Trainer, type: :model do
  describe "validations" do
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "associations" do
    it { is_expected.to have_many(:battle_pets).dependent(:destroy) }
  end
end
