require 'httparty'

body = HTTParty.get('http://pokemondb.net/pokedex/game/firered-leafgreen').body
info = body.scan(/\>(\w+|\#\d+)\</).flatten[13..-1].join(' ').split("\#")[1..-1].map { |data| data.chomp.split }
File.open('./pokemon.sql', 'w') do |f|
  f.puts "INSERT INTO\n\tpokemons (id, name, image_url)\nVALUES"
  info.map {|d| d[0..1] }.each do |pokeid, pokename|
    f.puts "\t(#{pokeid.to_i}, \"#{pokename}\", \"\/pokeimages\/#{pokeid}.png\"),"
  end

  f.puts "INSERT INTO\n\ttypes (id, name, pokemon_id)\nVALUES"
  counter = 1
  info.map { |d| d[2..-1] }.each_with_index do |type_arr, idx|
    type_arr.each do |type|
      f.puts "\t(#{counter}, \"#{type}\", #{idx + 1}),"
      counter += 1
    end
  end
end