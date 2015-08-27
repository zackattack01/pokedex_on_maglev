require 'webrick'

server = WEBrick::HTTPServer.new(:Port => 3000)

server.mount_proc("/") do |req, res|
	res.content_type = "text/text"
	res.body = req.path
end

trap('INT') do 
	server.shutdown
end

server.start