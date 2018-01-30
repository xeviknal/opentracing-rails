require 'spec_helper'
require 'action_controller'
require 'opentracing_rails'

describe 'ApplicationController' do
  let(:controller) { ActionController::Base.new }

  describe '#current_span' do
    it { expect(controller).to respond_to :current_span }
  end
end
