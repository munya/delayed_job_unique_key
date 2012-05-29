module Delayed
  module Backend
    module ActiveRecord
      class Job
        include Delayed::Backend::Base

        attr_accessible :priority, :run_at, :queue, :payload_object, :failed_at, :locked_at, :locked_by, :unique_key
        before_create :check_unique_key
      end
    end
  end
end