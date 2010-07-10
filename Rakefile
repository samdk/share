require 'rubygems'
require 'active_record'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

#require 'tasks/rails'

config = {
  :adapter  => 'sqlite3',
  :database => 'db/database.sqlite3',
  :pool     => 5,
  :timeout  => 5000
}

namespace :db do
  desc "Set up the database environment"
  task :environment do
    ActiveRecord::Base.establish_connection(config)
    ActiveRecord::Base.connection
  end

  task :create do
    if File.exist? config[:database]
      $stderr.puts "#{config[:database]} already exists"
    else
      begin
        # Create the SQLite database
        ActiveRecord::Base.establish_connection(config)
        ActiveRecord::Base.connection
      rescue
        $stderr.puts $!, *($!.backtrace)
        $stderr.puts "Couldn't create database for #{config.inspect}"
      end
    end
  end

  desc "Migrate the database"
  task :migrate => :environment do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate/")
  end

  desc 'Drops the database'
  task :drop do
    begin
      FileUtils.rm(config[:database])
    rescue Exception => e
      puts "Couldn't drop #{config[:database]} : #{e.inspect}"
    end
  end
end

