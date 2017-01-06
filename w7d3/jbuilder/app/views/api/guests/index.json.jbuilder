json.array! @guests do |guest|
  if guest.age.between?(40, 50)
    json.partial! 'guest', guest: guest
  end
end
