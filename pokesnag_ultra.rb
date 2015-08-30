require 'httparty'

pokemons = []
abilities = {}
poke_abilities = []
types = {}
poke_types = []
moves = {}
poke_moves = []

## shoutout to pokeapi their db is incredible
(1..151).each do |pokeid|
  info = HTTParty.get("http://pokeapi.co/api/v1/pokemon/#{pokeid}")
  pokemon = info.select { |k, v| %w{ name sp_atk sp_def weight height attack defense catch_rate }.include? k }
  info['abilities'].each do |ability|
    unless abilities[ability['name']]
      abilities[ability['name']] = abilities.count + 1
    end
    poke_abilities << [poke_abilities.count + 1, pokeid, abilities[ability['name']]]
  end

  info['types'].each do |type|
    unless types[type['name']]
      types[type['name']] = types.count + 1
    end
    poke_types << [poke_types.count + 1, pokeid, types[type['name']]]
  end

  these_moves = info['moves'].select { |attrs| attrs['learn_type'] == "level up" }
  these_moves.each do |move|
    unless moves[move['name']]
      moves[move['name']] = HTTParty.get("http://pokeapi.co#{move['resource_uri']}").select {|k, v| %w{ description accuracy power pp }.include? k }
      moves[move['name']]['id'] = moves.count + 1                    
    end
    poke_moves << [poke_moves.count + 1, pokeid, moves[move['name']]['id']]
  end

  pokemon['description'] = HTTParty.get("http://pokeapi.co#{info['descriptions'][0]['resource_uri']}")['description'] 
  pokemon['encoded_img'] = [HTTParty.get("http://pokeapi.co/media/img/#{pokeid}.png")].pack('m0')
  pokemon['id'] = pokeid
  pokemons << pokemon
end

File.open('pokesnag_ultra.sql', 'a') do |f|
  f.puts "INSERT INTO\n\tpokemons (attack, catch_rate, defense, height, name, sp_atk, sp_def, weight, description, encoded_img, id)\nVALUES"
  pokemons.each do |poke|
    f.puts "\t('#{ poke.values.map { |val| val.frozen? ? val : val.gsub("'", "''") }.join("', '") }'),"
  end
  f.puts "\n\n"
  
  f.puts "INSERT INTO\n\tabilities (name, id)\nVALUES"
  abilities.to_a.each do |ability|
    f.puts "\t('#{ ability.map { |val| val.frozen? ? val : val.gsub("'", "''") }.join("', '") }'),"
  end
  f.puts "\n\n"

  f.puts "INSERT INTO\n\tpoke_abilities (id, pokemon_id, ability_id)\nVALUES"
  poke_abilities.each_with_index do |ability|
    f.puts "\t('#{ ability.join("', '") }'),"
  end
  f.puts "\n\n"
  
  f.puts "INSERT INTO\n\ttypes (name, id)\nVALUES"
  types.to_a.each do |type|
    f.puts "\t('#{ type.join("', '") }'),"
  end
  f.puts "\n\n"
  
  f.puts "INSERT INTO\n\tpoke_types (id, pokemon_id, type_id)\nVALUES"
  poke_types.each do |type|
    f.puts "\t('#{ type.join("', '") }'),"
  end
  f.puts "\n\n"
  
  f.puts "INSERT INTO\n\tmoves (accuracy, description, power, pp, id, name)\nVALUES"
  
  moves.map { |k, v| v.merge({ 'name' => k }).values }.each do |move|
    f.puts "\t('#{ move.map { |val| val.frozen? ? val : val.gsub("'", "''") }.join("', '") }'),"
  end
  f.puts "\n\n"
  
  f.puts "INSERT INTO\n\tpoke_moves (id, pokemon_id, move_id)\nVALUES"
  poke_moves.each do |move|
    f.puts "\t('#{ move.join("', '") }'),"
  end
end