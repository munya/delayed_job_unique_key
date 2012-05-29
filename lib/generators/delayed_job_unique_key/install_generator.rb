require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record/migration'


module DelayedJobUniqueKey
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    extend ActiveRecord::Generators::Migration

    self.source_paths << File.join(File.dirname(__FILE__), 'templates')

    def create_migration_file
      migration_template 'add_unique_key_migration.rb', 'db/migrate/add_unique_key_delayed_jobs.rb'
    end
  end
end
