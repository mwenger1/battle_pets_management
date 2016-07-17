require 'rails_helper'

RSpec.describe BattlePet, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:trainer) }
  end

  describe "validations" do
    BattlePet::SCOREABLE_ATTRIBUTES.each do |scoreable_attribute|
      it do
        is_expected.to validate_numericality_of(scoreable_attribute).only_integer.
          is_greater_than_or_equal_to(0).is_less_than(100)
      end
    end

    it do
      is_expected.to validate_uniqueness_of(:name).
        scoped_to(:trainer_id).case_insensitive
    end
  end

  describe "#before_create" do
    context "SCOREABLE_ATTRIBUTES are provided" do
      it "sets provided attributes" do
        strength = 2
        wit = 3
        agility = 4
        senses = 5

        battle_pet = create(
          :battle_pet,
          strength: strength,
          wit: wit,
          agility: agility,
          senses: senses
        )

        expect(battle_pet.strength).to eq strength
        expect(battle_pet.wit).to eq wit
        expect(battle_pet.agility).to eq agility
        expect(battle_pet.senses).to eq senses
      end
    end

    context "SCOREABLE_ATTRIBUTES are NOT provided" do
      it "distributes STARTER_EXPERIENCE_POINTS randomly across attributes" do
        battle_pet = create(
          :battle_pet,
          strength: nil,
          wit: nil,
          agility: nil,
          senses: nil
        )

        all_scores = scoreable_attributes.map do |scoreable_attribute|
          battle_pet.send(scoreable_attribute)
        end

        expect(all_scores.uniq.length).to be > 1
        expect(all_scores.sum).to eq BattlePet::STARTER_EXPERIENCE_POINTS
      end
    end
  end

  def scoreable_attributes
    BattlePet::SCOREABLE_ATTRIBUTES
  end
end
