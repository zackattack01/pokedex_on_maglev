require 'webrick'
require_relative '../lib/controller_base'
require_relative '../lib/router'
require_relative '../lib/db_connection'
require_relative '../lib/sql_object'

DBConnection.reset

class Pokemon < SQLObject
  self.table_name = 'pokemons'

  has_many :types, through: :poke_types, source: :type
  has_many :poke_types, foreign_key: :pokemon_id
  has_many :poke_abilities, foreign_key: :pokemon_id

  finalize!
end

class PokeType < SQLObject
  self.table_name = 'poke_types'

  belongs_to :pokemon
  belongs_to :type

  finalize!
end

class Type < SQLObject
  self.table_name = 'types'

  has_many :poke_types, foreign_key: :type_id
  has_many :pokemon, through: :poke_types, source: :pokemon
  
  finalize!
end

class PokeAbility
  self.table_name = 'poke_abilities'

  belongs_to :pokemon
  belongs_to :ability

  finalize!
end

class Ability < SQLObject
  self.table_name = 'abilities'

  has_many :poke_abilities, foreign_key: :ability_id
  has_many :pokemon, through: :poke_abilities, source: :pokemon
  
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

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  route = router.run(req, res)
end

trap('INT') { server.shutdown }
server.start