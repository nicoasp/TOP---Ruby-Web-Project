require 'socket'

host = 'localhost'
port = 2000
path = "./index.html"

request = "GET #{path} HTTP/1.0\r\n\r\n"

socket = TCPSocket.open(host, port)
socket.print(request)

while line = socket.gets
	if line.include?("404")
		puts "404 Not Found"
	end
	if line.include?("<")
		puts line.chop
	end
end
