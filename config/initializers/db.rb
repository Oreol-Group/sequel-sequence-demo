# frozen_string_literal: true

# CODE EXECUTION ORDER IS IMPORTANT DURING SEQUEL INITIALIZATION PROCESS.
# See http://sequel.jeremyevans.net/rdoc/files/doc/code_order_rdoc.html

require 'sequel/core'

# Include the Postgres JSON Operations extension
# https://sequel.jeremyevans.net/rdoc/files/doc/postgresql_rdoc.html
Sequel.extension(:pg_json_ops) if Settings.db.adapter == 'postgres'

sequel_sequence_demo_database_url = lambda do
  case Settings.db.adapter
  when 'sqlite'
    "sqlite://data/sqlite/#{ENV.fetch('DATABASE', '')}.sqlite3"
  when 'mysql'
    'mysql2://'\
    "#{ENV.fetch('MYSQL_USER', '')}:"\
    "#{ENV.fetch('MYSQL_PASSWORD', '')}@"\
    "#{ENV.fetch('MYSQL_HOST', '')}:"\
    "#{ENV.fetch('MYSQL_PORT', '')}/"\
    "#{ENV.fetch('DATABASE', '')}"
  when 'mariadb'
    'mysql2://'\
    "#{ENV.fetch('MARIADB_USER', '')}:"\
    "#{ENV.fetch('MARIADB_PASSWORD', '')}@"\
    "#{ENV.fetch('MARIADB_HOST', '')}:"\
    "#{ENV.fetch('MARIADB_PORT', '')}/"\
    "#{ENV.fetch('DATABASE', '')}"
  when 'postgres'
    'postgres://'\
    "#{ENV.fetch('POSTGRES_USER', '')}:"\
    "#{ENV.fetch('POSTGRES_PASSWORD', '')}@"\
    "#{ENV.fetch('POSTGRES_HOST', '')}:"\
    "#{ENV.fetch('POSTRGRES_PORT', '')}/"\
    "#{ENV.fetch('DATABASE', '')}"
  end
end
# Delete 'sequel_sequence_demo_database_url' from the environment, so it isn't accidently
# passed to subprocesses.  'sequel_sequence_demo_database_url' may contain passwords.
DB = Sequel.connect(sequel_sequence_demo_database_url.call)

# Load Sequel Database/Global extensions here
DB.extension :pagination

# https://github.com/jeremyevans/sequel/blob/master/lib/sequel/extensions/schema_dumper.rb
DB.extension :schema_dumper

if Settings.db.adapter == 'postgres'
  # Ask Sequel to use the Postgres JSON extension with your database
  DB.extension :pg_array, :pg_json

  # https://github.com/jeremyevans/sequel/blob/7a70ac6d719c21bcb404adf6159cbd2769d9246f/lib/sequel/extensions/pg_timestamptz.rb
  DB.extension :pg_timestamptz

  # https://github.com/jeremyevans/sequel/blob/7a70ac6d719c21bcb404adf6159cbd2769d9246f/lib/sequel/extensions/pg_json.rb
  DB.wrap_json_primitives = true
end

Sequel.default_timezone = :utc
