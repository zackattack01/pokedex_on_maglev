require_relative '../../lib/controller_base'

class ImagesController < ControllerBase
  def render_image
    img = params[:image_name]
    full_path = File.dirname(__FILE__) + "/../assets/images/#{img}.#{params[:img_ext]}"
    res.body = File.read(full_path)
    res.content_type = "image/#{params[:img_ext]}"

    @already_built_response = true
  end
end