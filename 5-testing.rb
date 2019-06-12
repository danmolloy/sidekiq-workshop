Sidekiq::Testing.fake! # ? pushes all jobs into a jobs array (default)
Sidekiq::Testing.inline! # ? runs the job immediately 
Sidekiq::Testing.disable! # ? push jobs to redis as normal

###########

# Some tests

Sidekiq::Testing.inline! do
  # Some other tests
end

# Here we're back to fake testing again.
 
###########

expect{ HardWorker.perform_async(1, 2) }.to change(HardWorker.jobs, :size).by(1)

############

expect(HardWorker.jobs.size).to eq 0
HardWorker.perform_async(1, 2)
HardWorker.perform_async(2, 3)
expect(HardWorker.jobs.size).to eq 2

HardWorker.drain
expect(HardWorker.jobs.size).to eq 0


###############

HardWorker.drain

HardWorker.clear

Sidekiq::Worker.drain_all

Sidekiq::Worker.clear_all
