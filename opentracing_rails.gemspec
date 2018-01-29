$:.push File.expand_path("../lib", __FILE__)

require 'opentracing_rails/version'

Gem::Specification.new do |s|
    s.name        = 'opentracing_rails'
    s.version     = OpentracingRails::VERSION
    s.date        = '2018-01-25'
    s.summary     = "Distributed tracing for Rails"
    s.description = "Opentracing instrumentation for Rails projects"
    s.authors     = ["cfcosta", "xeviknal"]
    s.email       = 'no@email.com'
    s.files       = Dir["lib/**/*"]
    s.homepage    = 'http://opentracing.io'
    s.license     = 'Apache-2.0'

    # Dependencies
    s.add_dependency('rack-tracer', '~> 0.3.0')
    s.add_dependency('faraday', '~> 0.14.0')
    s.add_dependency('faraday-tracer', '~> 0.2.0')
    s.add_development_dependency('rails', '> 3')
end
