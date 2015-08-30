require_relative '../../lib/controller_base'

class ScriptsController < ControllerBase
  def script
    filename = params[:scriptname]
    full_path = File.dirname(__FILE__) + "/../assets/javascripts/#{filename}.js"
    res.body = File.read(full_path)
    res.content_type = "application/javascript"

    @already_built_response = true
  end
end