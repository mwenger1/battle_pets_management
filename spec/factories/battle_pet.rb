FactoryGirl.define do
  factory :battle_pet do
    sequence(:name) { |n| "BattlePet #{n}" }
    strength 1
    agility 1
    wit 1
    senses 1

    after(:build) do |battle_pet|
      unless battle_pet.trainer_id.present?
        battle_pet.trainer = build(:trainer)
      end
    end
  end
end
