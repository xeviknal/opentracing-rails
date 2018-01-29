module OpenTracing
  module Rails
    module Subscribers
      class ActiveRecord
        attr_accessor :env

        def initialize(env)
          self.env = env
        end

        def call(name, started, finished, unique_id, payload)
          span = OpenTracing.start_span(payload[:name], child_of: env['rack.span'], start_time: started, tags: payload)
          span.finish(end_time: finished)
        end
      end
    end
  end
end
