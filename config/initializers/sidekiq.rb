Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }
end


Sidekiq::Cron::Job.create(
  name: "Daily Job - every day at 8AM",
  cron: "0 8 * * *",
  class: "DailyJob",
  description: "Daily Job - every day at 8AM"
)
