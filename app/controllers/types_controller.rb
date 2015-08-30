require_relative '../../lib/controller_base'
require_relative '../models/type'

class TypesController < ControllerBase
  def index
    #@types = 
    render('index')
  end
end