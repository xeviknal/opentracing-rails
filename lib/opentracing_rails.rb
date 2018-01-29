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
    end
  end
end
