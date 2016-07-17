class BattlePet < ApplicationRecord
  STARTER_EXPERIENCE_POINTS = 20
  SCOREABLE_ATTRIBUTES = %i(strength wit senses agility)

  SCOREABLE_ATTRIBUTES.each do |scoreable_attribute|
    validates(
      scoreable_attribute,
      presence: true,
      numericality: {
        only_integer: true,
        less_than: 100,
        greater_than_or_equal_to: 0
      }
    )
  end

  validates(
    :name,
    presence: true,
    uniqueness: { scope: :trainer_id, case_sensitive: false }
  )

  belongs_to :trainer

  before_validation :set_starter_experience, on: :create

  private

  def set_starter_experience
    if scoreable_attributes_not_set?
      randomly_assign_starter_points
    end
  end

  def scoreable_attributes_not_set?
    SCOREABLE_ATTRIBUTES.map{ |attribute| send(attribute) }.compact.empty?
  end

  def randomly_assign_starter_points
    remaining_starter_points = STARTER_EXPERIENCE_POINTS

    SCOREABLE_ATTRIBUTES.each_with_index do |attribute, index|
      random_value = rand(remaining_starter_points)

      if index != (SCOREABLE_ATTRIBUTES.size - 1)
        remaining_starter_points -= random_value
        attribute_value = random_value
      else
        attribute_value = remaining_starter_points
      end

      send("#{attribute}=", attribute_value)
    end
  end
end
