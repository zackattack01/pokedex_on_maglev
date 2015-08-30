require_relative '../../lib/controller_base'

class StyleSheetsController < ControllerBase
  def style
    filename = params[:filename]
    full_path = File.dirname(__FILE__) + "/../assets/stylesheets/#{filename}.css"
    res.body = File.read(full_path)
    res.content_type = "text/css"

    @already_built_response = true
  end
end