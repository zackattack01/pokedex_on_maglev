require_relative '../../lib/controller_base'
require_relative '../models/move'

class MovesController < ControllerBase
  def show
    @move = Move.find(params[:id].to_i)
    render('show')
  end
end