require 'rack/tracer'
require 'faraday'
require 'faraday/tracer'
require 'opentracing_rails/action_controller/base'
require 'opentracing_rails/instrumenters'
require 'opentracing_rails/instrumenters/active_record'
require 'opentracing_rails/subscribers/active_record'

module OpenTracing
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace OpenTracing::Rails

      initializer 'opentracing.rails.add_rack_tracer' do |app|
        app.config.middleware.insert_before(Rack::Sendfile, Rack::Tracer)
      end

      initializer 'opentracing.rails.instrument_active_record' do |_|
        ActionController::Base.send(:include, OpenTracing::Rails::Instrumenters::ActiveRecord)
      end
    end

    def self.configure
      yield self
    end

    mattr_writer :skip_schema_queries

    def self.skip_schema_queries
      @skip_schema_queries ||= true
    end
  end
end
