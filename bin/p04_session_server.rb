require 'webrick'
require_relative '../lib/phase4/controller_base'
require_relative '../lib/bonus/flash'
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html

class MyController < Phase4::ControllerBase
  def go
    session["count"] ||= 0
    session["count"] += 1
    flash.now[:count] = "now its #{session['count']}"
    flash.now[:num_vals] = []
    flash.now[:num_vals] << "fizz" if session['count'] % 3 == 0 
    flash.now[:num_vals] << "buzz" if session["count"] % 5 == 0
    flash.now[:num_vals] = [flash.now[:num_vals].join] if flash.now[:num_vals].length == 2
    flash.now[:num_vals] = ["#{session['count']}"] if flash.now[:num_vals].empty?
    render :counting_show
    flash.now[:error] = "you should never see me"
  end
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  MyController.new(req, res).go
end

trap('INT') { server.shutdown }
server.start