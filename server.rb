require 'socket'
require 'json'


server = TCPServer.open(2000)
loop {
	client = server.accept
	req = client.gets.split
	case req[0]
	when "GET"
		path = req[1]
		body = ""
		if File.exist?(path)
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
		client.gets
		client.gets
		client.gets
		content = client.gets
		params = JSON.parse(content)
		template = File.read("./thanks.html")
		data = "<li>Name: #{params["viking"]["name"]}</li><li>Email: #{params["viking"]["email"]}</li>"
		template.gsub!("<%= yield %>", data)
		client.puts template
	else
		client.puts "Invalid request"
	end

	client.puts "Closing the connection. Bye!"
	client.close
	puts params
}



