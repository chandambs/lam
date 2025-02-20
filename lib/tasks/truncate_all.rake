# lib/tasks/truncate_all.rake
namespace :db do
    desc "Truncate all tables"
    task truncate_all: :environment do
      ActiveRecord::Base.connection.tables.each do |table|
        next if table == 'schema_migrations' || table == 'ar_internal_metadata'
        ActiveRecord::Base.connection.execute("TRUNCATE #{table} CASCADE")
      end
    end
  end