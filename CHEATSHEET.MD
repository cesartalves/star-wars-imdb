# Command CheatSheet (for self-reference & copy/paste)

gem 'devise'
rails generate devise:install

config/environments/development.rb:

config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

rails generate devise MODELNAME

rails g devise User

docker run -e POSTGRES_PASSWORD=123456 -p 5432:5432 postgres

ActiveSupport::Dependencies.autoload_paths
