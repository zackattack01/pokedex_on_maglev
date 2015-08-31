require_relative '../../lib/controller_base'
require_relative '../models/type'

class TypesController < ControllerBase
  def show
    @type = Type.find(params[:id].to_i)
    render('show')
  end
end