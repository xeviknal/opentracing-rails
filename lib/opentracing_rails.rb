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

      initializer "opentracing.rails.add_rack_tracer" do |app|
        app.config.middleware.insert_before(Rack::Sendfile, Rack::Tracer)
      end
    end
  end
end
