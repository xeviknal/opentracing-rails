module OpenTracing
  module Rails
    module Instrumenters
      module ActiveRecord
        extend ActiveSupport::Concern

        included do
          before_action :instrument_active_record_calls
        end

        def instrument_active_record_calls
          subscriber = Subscribers::ActiveRecord.new(request.env)
          ActiveSupport::Notifications.subscribe('sql.active_record', subscriber)
        end
      end
    end
  end
end
