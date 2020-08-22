class GrowthRecord < ApplicationRecord
  validates :age_of_the_moon, uniqueness: { scope: :age, message: '年齢と月齢は重複して記録できません'}
end
