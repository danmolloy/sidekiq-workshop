# * Things to keep in mind
  # ? No guaruntee of when job will run… Queue can be backed up or not processing
  # ? No guarantee of how many times job will run (It will be 1 or more) - retries, restarts (25 seconds to shutdown)
  # ? Order not guarunteed - jobs must be independant
  # ? JSON serialisation

# * Best Practices

  # ? Make job parameters small and simple
  # ! BAD - will try to serialize asset with to_s and produce "#<Asset:0x0000000006e57288>"
    # ! Even if serialization worked, job may not process for a while. Asset could change in DB and this copy is stale
    asset = Asset.find(asset_id)
    SomeWorker.perform_async(asset)
  # * GOOD
    SomeWorker.perform_async(asset_id)

  # ? Make jobs idempotent. Retries and restarts mean they can run many times. 
  # ? Make jobs transactional - this goes hand in hand with idempotency… if a job fails halfway through it should undo the previous work, doing this correctly gives you idempotency.
  # ? Embrace concurrency - Sidekiq can run many jobs in parallel and it makes sense to split large processes into parallel chunks to take advantage of this.
  # ? Keep a small amount of logic in workers. Ideally a worker just calls a service.