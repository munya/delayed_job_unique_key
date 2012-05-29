module Delayed
  module Backend
    module Base
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        # Add a job to the queue
        def enqueue(*args)
          options = {
              :priority => Delayed::Worker.default_priority
          }.merge!(args.extract_options!)

          options[:payload_object] ||= args.shift

          if args.size > 0
            warn "[DEPRECATION] Passing multiple arguments to `#enqueue` is deprecated. Pass a hash with :priority and :run_at."
            options[:priority] = args.first || options[:priority]
            options[:unique_key] = options[:unique_key]
            options[:run_at] = args[1]
          end

          unless options[:payload_object].respond_to?(:perform)
            raise ArgumentError, 'Cannot enqueue items which do not respond to perform'
          end

          if Delayed::Worker.delay_jobs
            self.new(options).tap do |job|
              Delayed::Worker.lifecycle.run_callbacks(:enqueue, job) do
                job.hook(:enqueue)
                job.save
              end
            end
          else
            Delayed::Job.new(:payload_object => options[:payload_object]).tap do |job|
              job.invoke_job
            end
          end
        end
      end

      protected

      def check_unique_key
        return true if !self.respond_to?(:unique_key) || self.unique_key.blank?
        self.class.where(:unique_key => self.unique_key, :locked_at => nil).first.nil?
      end

    end
  end
end