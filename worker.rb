class Worker
  def initialize
    @queue = Queue.new
    @client = HTTPClient.new
  end

  def <<(json)
    @queue << json
  end

  def spawn(count)
    count.times do
      Thread.new do
        while true
          data = @queue.pop
          @client.post('https://android.googleapis.com/send', data, {
            "Authorization" => "key:AIzaSyCABSTd47XeIH",
            "Content-Type" => "application/josn"
          })
        end
      end
    end
  end
end

