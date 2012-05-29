class AddUniqueKeyDelayedJobs < ActiveRecord::Migration
  def self.up
    add_column :delayed_jobs, :unique_key, :string
    add_index :delayed_jobs, [:unique_key, :locked_at], :name => 'delayed_jobs_unique_key'
  end

  def self.down
    remove_index :delayed_jobs, :name => 'delayed_jobs_unique_key'
    remove_column :delayed_jobs, :unique_key
  end
end