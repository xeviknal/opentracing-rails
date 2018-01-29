# opentracing_rails - Unleashing opentracing for Rails

Distributed tracing instrumentation for Ruby on Rails applications based on Opentracing standard.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'opentracing_rails'
```

This gem is based on [Opentracing](https://github.com/opentracing/opentracing-ruby/) standard but is not bound to any implementation of it.
Therefore, you need to choose which implementation want to use.

Once you have chosen the backend, add the following lines into an initializer specifying it:

### Jaeger

For instance, the [CNCF](https://www.cncf.io) project [Jaeger](https://github.com/jaegertracing/jaeger) and its ruby implementation [jaeger-client-ruby](https://github.com/salemove/jaeger-client-ruby).

```ruby
# config/initializers/opentracing.rb

require 'jaeger/client'

OpenTracing.global_tracer = Jaeger::Client.build(
  service_name: Rails.application.class.parent_name,
  host: 'localhost',
  port: 6831)
```

### Zipkin
An alternative to Jaeger, there is [Zipkin](https://zipkin.io/) which has its ruby implementation [zipking-ruby-opentracing](https://github.com/salemove/zipkin-ruby-opentracing).

```ruby
# config/initializers/opentracing.rb

require 'zipkin/tracer'
OpenTracing.global_tracer = Zipkin::Tracer.build(
  url: 'http://localhost:9411',
  service_name: Rails.application.class.parent_name)

```

## Environment preparation

For running a Jaeger instance, you can use the official [All-in-one docker image](http://jaeger.readthedocs.io/en/latest/getting_started/#all-in-one-docker-image)
they provide for testing purposes. Within this image, also, you can find running the Jaeger UI running on `http://localhost:16686`.

The simplest way to start the all in one docker image is to use the pre-built image published to DockerHub (a single command line).
```bash
docker run -d -e COLLECTOR_ZIPKIN_HTTP_PORT=9411 -p5775:5775/udp -p6831:6831/udp -p6832:6832/udp \
  -p5778:5778 -p16686:16686 -p14268:14268 -p9411:9411 jaegertracing/all-in-one:latest
```

## Usage

### current_span

OpenTracing::Rails defines a `current_span` method which tells the whole trace information collected until the moment.
TODO: more info, if needed. maybe classname?

### Tracking http communications

TODO: section aim description

```ruby
conn = Faraday.new(url: 'http://localhost:3001/') do |faraday|
  faraday.use Faraday::Tracer, span: current_span

  faraday.request :url_encoded
  faraday.adapter Faraday.default_adapter
end

p conn.get('/').body
```

### Tracing special operations

TODO: explain how to create a new span inside the current trace.
smth like that:

```ruby
span = @tracer.start_span('interesting_transaction,
  child_of: parent_span,
  tags: {
    'component' => 'faraday',
    'span.kind' => 'client',
    'http.method' => 'GET'
    'http.url' => 'internal'
  }
)

# do all the interesting things here

span.finish
```

### Tracing ActiveRecord

OpenTracing::Rails traces all ActiveRecord transactions by default, without any
configuration. There are some options that can be set, though:

* `skip_schema_queries`: Avoid adding to the trace internal AR queries for schema, to not pollute the trace. Default: **true**.

## Draft tasks to do in future

[ ] Add Sidekiq support
[ ] Avoid changing config.ru for adding `use Rack::Tracer`
[ ] Set railsy names to traces (for better understanding on Opentracing backend)
[ ] Perhaps add the ActiveRecord tracer within a middleware? this way it could get the whole app traffic.
