require_relative '04_associatable2'

class Cat < SQLObject
end

p Cat.select(:name, :color, 'COUNT(*) AS count')
     .where(owner_id: 1)
     .group(:color)
     .having(color: 'black')
     .order(:name)
     .limit(1)
     .second!
