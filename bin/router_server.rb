require 'webrick'
require_relative '../lib/controller_base'
require_relative '../lib/router'
require_relative '../lib/db_connection'
require_relative '../lib/sql_object'

DBConnection.reset

class Pokemon < SQLObject
  self.table_name = 'pokemons'

  has_many :types, foreign_key: :pokemon_id

  finalize!
end

class Types < SQLObject
  self.table_name = 'types'

  belongs_to :pokemon

  finalize!
end
# $cats = [
#   { id: 1, name: "Curie" },
#   { id: 2, name: "Markov" }
# ]

# $types = [
#   { id: 1, pokemon_id: 1, text: "Curie loves string!" },
#   { id: 2, pokemon_id: 2, text: "Markov is mighty!" },
#   { id: 3, pokemon_id: 1, text: "Curie is cool!" }
# ]

class PokemonsController < ControllerBase
  def index
    @pokemons = Pokemon.all
    render('index')
  end
end

class TypesController < ControllerBase
  def index
    render('index')
  end
end

router = Router.new
router.draw do
  get Regexp.new("^/pokemon$"), PokemonsController, :index
  get Regexp.new("^/pokemon/(?<pokemon_id>\\d+)/types$"), TypesController, :index
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  route = router.run(req, res)
end

trap('INT') { server.shutdown }
server.start