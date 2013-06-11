class Worker
  def initialize
    @queue = Queue.new
    @client = HTTPClient.new
  end

  def <<(job)
    @queue << job
  end

  def spawn(count)
    count.times do
      Thread.new { work  }
    end
  end

  private

    def work
      while job = @queue.pop
        job.run
      end
    end
end

