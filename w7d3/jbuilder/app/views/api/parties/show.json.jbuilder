json.extract! @party, :name
json.guests @party.guests do |guest|
  json.partial! 'api/guests/guest', guest: guest
  json.gifts guest.gifts do |gift|
    json.extract! gift, :title, :description
  end
end
