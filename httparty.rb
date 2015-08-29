require 'httparty'


(1..151).each do |pokeid|
  HTTParty.get("http://pokeapi.co/api/v1/pokemon/#{pokeid}")
end