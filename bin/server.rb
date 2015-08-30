require 'webrick'
require_relative '../lib/controller_base'
require_relative '../lib/router'
require_relative '../lib/db_connection'
require_relative '../lib/sql_object'
require 'pry'

DBConnection.reset

class Type < SQLObject
  self.table_name = 'types'

  has_many :poke_types, foreign_key: :type_id
  has_many_through :pokemon, :poke_types, :pokemon
  
  finalize!
end

class PokeType < SQLObject
  self.table_name = 'poke_types'

  belongs_to :pokemon
  belongs_to :type

  finalize!
end


class Ability < SQLObject
  self.table_name = 'abilities'

  has_many :poke_abilities, foreign_key: :ability_id
  has_many_through :pokemon, :poke_abilities, :pokemon
  
  finalize!
end

class PokeAbility < SQLObject
  self.table_name = 'poke_abilities'

  belongs_to :pokemon
  belongs_to :ability

  finalize!
end

class Move < SQLObject
  self.table_name = 'moves'

  has_many :poke_moves
  has_many_through :pokemon, :poke_moves, :pokemon
  
  finalize!
end

class PokeMove < SQLObject
  self.table_name = 'poke_moves'

  belongs_to :pokemon
  belongs_to :move

  finalize!
end

class Pokemon < SQLObject
  self.table_name = 'pokemons'

  has_many :poke_types, foreign_key: :pokemon_id
  has_many_through :types, :poke_types, :type
  has_many :poke_abilities, foreign_key: :pokemon_id, class_name: :Ability

  finalize!
end

class PokemonsController < ControllerBase
  def index
    @pokemons = Pokemon.all
    render('index')
  end

  def show
    @pokemon = Pokemon.find(params[:id].to_i)
    render('show')
  end
end

class TypesController < ControllerBase
  def index
    #@types = 
    render('index')
  end
end

router = Router.new
router.draw do
  get Regexp.new("^/pokemon$"), PokemonsController, :index
  get Regexp.new("^/pokemon/(?<id>\\d+)$"), PokemonsController, :show
  get Regexp.new("^/pokemon/(?<pokemon_id>\\d+)/types$"), TypesController, :index
end

# binding.pry
server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  route = router.run(req, res)
end

trap('INT') { server.shutdown }
server.start