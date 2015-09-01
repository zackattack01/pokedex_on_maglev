require_relative '../../lib/controller_base'
# require_relative '../models/zack'

class ZacksController < ControllerBase
  def root
    render('root')
  end

  def tab
    if params[:tab_name] == "Projects"
      render('projects')
    elsif params[:tab_name] == "Home"
      render('home')
    else
      raise "unmatched params"
    end
  end
end