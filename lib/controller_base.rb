require 'active_support'
require 'active_support/core_ext'
require 'erb'
require 'active_support/inflector'
require_relative './session'
require_relative './params'
require_relative './flash'

class ControllerBase
  attr_reader :req, :res, :params, :header

  def initialize(req, res, route_params = {})
    @req, @res = req, res
    @params = Params.new(req, route_params)
    @header = ERB.new(File.read("app/views/_app_header.html.erb")).result(binding)
  end

  def already_built_response?
    @already_built_response
  end

  def redirect_to(url)
    raise "Response already rendered" if already_built_response?
    res.status = (302)
    res.header['location'] = url
    session.store_session(res)
    flash.store_flash(res)
    @already_built_response = true
  end

  def render_content(content, content_type)
    raise "Response already rendered" if already_built_response?
    res.content_type = content_type
    res.body = content
    session.store_session(res)
    flash.store_flash(res)
    @already_built_response = true
  end

  def render(template_name)
    if self.class.to_s =~ /Zack/
      path = "app/views/#{self.class.to_s.underscore}/#{template_name}.html"
      content = File.read(path)
    else
      path = "app/views/#{self.class.to_s.underscore}/#{template_name}.html.erb"
      content = header + ERB.new(File.read(path)).result(binding) + "</body></html>"
    end
    render_content(content, "text/html")
    flash.store_flash(res)
  end

  def session
    @session ||= Session.new(req)
  end

  def flash
    @flash ||= Flash.new(req)
  end

  def invoke_action(name)
    self.send(name)
    render(name.to_sym) unless already_built_response?
  end
end