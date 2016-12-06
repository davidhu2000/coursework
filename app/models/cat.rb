# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ActiveRecord::Base
  COLORS = ['orange', 'black', 'white', 'brown', 'grey'].freeze

  validates :birth_date, presence: true
  validates :name, presence: true
  validates :color, presence: true, inclusion: { in: COLORS, message: "%{value} is not a valid color" }
  validates :sex, presence: true, inclusion: { in: ['M', 'F'] }

  def age
    birth_year = self.birth_date.year
    Time.now.year - birth_year
  end
end
