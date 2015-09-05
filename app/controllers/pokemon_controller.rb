require_relative '../../lib/controller_base'
require_relative '../models/pokemon'

class PokemonsController < ControllerBase
  def root
    render('root')
  end

  def index
    @pokemons = Pokemon.all
    render('index')
  end

  def show
    @pokemon = Pokemon.find(params[:id].to_i)
    render('show')
  end
end