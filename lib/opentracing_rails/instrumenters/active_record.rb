module Instrumenters::ActiveRecord
  extend ActiveSupport::Concern

  included do
    before_action :_instrument_active_record_calls
  end

  def _instrument_active_record_calls
    subscriber = Subscribers::ActiveRecord.new(request.env)
    ActiveSupport::Notifications.subscribe('sql.active_record', subscriber)
  end
end
