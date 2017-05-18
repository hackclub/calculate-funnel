require 'concurrent'

class WorkPool
  def initialize(thread_count)
    @thread_count = thread_count
    @pool = Concurrent::FixedThreadPool.new(@thread_count)
  end

  def post(*args, &block)
    @pool.post(*args, &block)
  end

  def wait_for_completion
    loop do
      sleep 0.5
      break if @pool.queue_length == 0
    end
  end

  def shutdown
    @pool.shutdown
  end
end
