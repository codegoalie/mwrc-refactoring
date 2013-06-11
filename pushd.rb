require 'thread'
require 'httpclient'
require 'json'

queue = Queue.new
client = HTTPClient.new
socket = UDPSocket.new

10.times do
  Thread.new do
    while true
      data = queue.pop
      client.post('https://android.googleapis.com/send', data, {
        "Authorization" => "key:AIzaSyCABSTd47XeIH",
        "Content-Type" => "application/josn"
      })
    end
  end
end

socket.bind("0.0.0.0", 6889)

while data = socket.recvfrom(4096)
  case data[0].split.first
  when 'PING'
    socket.send('PONG', 0, data[1][3], data[1][1])
  when 'SEND'
    data[0][5..-1].match(/([a-zA-Z0-9_\-]*) "([^"]*)/)
    json = JSON.generate({
      "registration_ids" => [$1],
      "data" => { "alert" => $2 }
    })
    queue << json
  end
end
