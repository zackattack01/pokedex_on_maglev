require_relative '../../lib/controller_base'
# require_relative '../models/zack'

class ZacksController < ControllerBase
  def root
    render('show')
  end

  def projects
    render('projects')
  end
end