require_relative '04_associatable2'

class Cat < SQLObject
end

p Cat.select(:name, :color)
     .where(owner_id: 1)
     .all
