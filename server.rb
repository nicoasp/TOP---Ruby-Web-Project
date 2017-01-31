require 'socket'



server = TCPServer.open(2000)
loop {
	client = server.accept
	req = client.gets.split
	case req[0]
	when "GET"
		client.puts "GET request!"
		path = req[1]
		status_code = 0
		reason_phrase = ""
		body = ""
		success = File.exist?(path)
		if success
			body = File.read(path)
			status_code = 200
			reason_phrase = "OK"
		else
			status_code = 404
			reason_phrase = "Not Found"
		end

		client.puts	"HTTP/1.0 #{status_code} #{reason_phrase}"
		client.puts	"Date: Time.now.ctime"
		client.puts	"Content-Length: #{body.size}"
		client.puts
		client.puts	"#{body}"

	when "POST"
		client.puts "POST request"
	else
		client.puts "Invalid request"
	end




	client.puts "Closing the connection. Bye!"
	client.close
}