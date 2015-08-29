require 'httparty'

abilities = {}
poke_abilities = []
types = {}
poke_types = []
moves = {}
poke_moves = []

File.open('pokeinfo.txt')
(1..151).each do |pokeid|
  info = HTTParty.get("http://pokeapi.co/api/v1/pokemon/#{pokeid}")
  info['abilities'].each do |ability|
    unless abilities[ability['name']]
  end
  name = info['name']
  species = info['species']
  types = info
  moves = info['moves'].select { |attrs| attrs['learn_type'] == "level up" }.each do |move|
    unless moves[move['name']]
      moves[move['name']] = HTTParty.get("http://pokeapi.co#{move['resource_uri']}")
                            .select!{|k, v| %w{ description accuracy power pp }.include?(k) }
    end
  end
  description = info['descriptions'][0]['resource_uri'] || "Words cannot describe the beauty that is #{name}"
end