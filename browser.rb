require 'socket'
require 'json'

host = 'localhost'
port = 2000
path = "./index.html"

puts "Which type of request do you want to make? (GET / POST)"
request_type = gets.chomp.upcase

request = "#{request_type} #{path} HTTP/1.0\r\n\r\n"
socket = TCPSocket.open(host, port)
socket.puts(request)



if request_type == "POST"
	puts "Type the name of your Viking"
	name = gets.chomp
	puts "Type the email of your viking"
	email = gets.chomp
	form_data = {:viking => {:name => name, :email => email}}

	socket.puts "Content-Length: #{form_data.to_json.size}"
	socket.puts
	socket.puts form_data.to_json

	while line = socket.gets
		puts line
	end

elsif request_type == "GET"
	while line = socket.gets
		if line.include?("404")
			puts "404 Not Found"
		end
		if line.include?("<")
			puts line.chop
		end
	end

end