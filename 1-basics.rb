# * https://github.com/mperham/sidekiq/wiki

# * Sidekiq architecture:

# * Client: 
  # ? Ruby process (in this case Rails server) that creates jobs for later processing.
  # ? Creates Hash representing the job, serialise to JSON and send to redis.
  # ? Arguments to worker must be simple JSON datatypes - no ruby objects or symbols.

# * Redis: 
  # ? Simple in-memory key-value database.  

# * Server: 
  # ? Separate process from Rails server. Loads Rails environment. 
  # ? Continuously pulls jobs from Redis queue and processes them. 
  # ? Creates a new instance of specified worker class and calls perform with provided arguments. 


class HardWorker
  include Sidekiq::Worker
  def perform(name, count)
    # do something
  end
end

HardWorker.perform_async('bob', 5)
HardWorker.perform_in(5.minutes, 'bob', 5)
HardWorker.perform_at(5.minutes.from_now, 'bob', 5)

# ! Bypass redis/sidekiq process & perform synchronously - should avoid
HardWorker.new.perform('bob', 5) 

