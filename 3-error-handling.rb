# * Error handling

# ? Let sidekiq catch your errors to handle retries. 
  # ? If you need to rescue errors to do transactional stuff, re-raise them at the end of the block.
# ? By default sidekiq will retry 25 times over 21 days (exponential backoff). This is fully adjustable.
# ? Job goes to dead queue after retries are exhausted. Manually retryable, kept for 6 months.
# ? Web UI
# ? Retries exhausted block