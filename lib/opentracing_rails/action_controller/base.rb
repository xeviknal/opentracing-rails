module ActionController
  class Base
    def current_span
      request.env['rack.span']
    end
  end
end
