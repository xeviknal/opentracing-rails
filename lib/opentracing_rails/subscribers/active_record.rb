module OpenTracing
  module Rails
    module Subscribers
      class ActiveRecord
        attr_accessor :env

        def initialize(env)
          @env = env
        end

        def call(name, started, finished, unique_id, payload)
          return if OpenTracing::Rails.skip_schema_queries and payload[:name] == 'SCHEMA'

          span = OpenTracing.start_span(payload[:name], child_of: env['rack.span'], start_time: started, tags: payload)
          span.finish(end_time: finished)
        end
      end
    end
  end
end
