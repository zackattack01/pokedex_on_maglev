require 'json'
require 'webrick'

class Session
  def initialize(req)
    our_cookie = req.cookies.find do |cookie| 
      cookie.name == '_rails_lite_app' 
    end
    @cookie = our_cookie.nil? ? {} : JSON.parse(our_cookie.value)
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  def store_session(res)
    res.cookies << WEBrick::Cookie.new('_rails_lite_app', @cookie.to_json)
  end
end