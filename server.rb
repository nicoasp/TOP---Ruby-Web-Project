require 'socket'

server = TCPServer.open(2000)
loop {
	client = server.accept
	if client.gets.include?("GET")
		client.puts "GET request!"
	end


	client.puts(Time.now.ctime)
	client.puts "Closing the connection. Bye!"
	client.close
}