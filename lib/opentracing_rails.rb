class OpentracingRails
  def self.trace
    'that is a trace'
  end

  require 'rack/tracer'
  require 'faraday'
  require 'faraday/tracer'
  require 'opentracing_rails/action_controller/base'
end
