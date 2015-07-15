# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/app/benevole/current"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/app/benevole/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/app/benevole/current/log/unicorn.log"
stdout_path "/app/benevole/current/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.benevole.sock"

# Number of processes
# worker_processes 4
worker_processes 3

# Time-out
timeout 15

before_fork do |server, worker|
 if defined?(ActiveRecord::Base)
   ActiveRecord::Base.connection.disconnect!
 end
end

after_fork do |server, worker|
 if defined?(ActiveRecord::Base)
   config = ActiveRecord::Base.configurations[Rails.env] ||
               Rails.application.config.database_configuration[Rails.env]
   config['reaping_frequency'] =  10 # seconds
   config['pool'] = 10
   ActiveRecord::Base.establish_connection(config)
 end
end