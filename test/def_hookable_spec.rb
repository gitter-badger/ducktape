require_relative 'test_helper'

include Ducktape

class Names
  include Bindable

  bindable :names, default: Ducktape.hookable([])
end

class SimpleBindable
  include Bindable

  bindable :name
end

RSpec.instance_eval do

  describe 'Ducktape::hookable' do

    let(:src) do
      Names.new.tap do |src|
        src.names.push :a, :b, :c
      end
    end

    let(:tgt) do
      SimpleBindable.new.tap do |tgt|
        tgt.bind :name, src, 'names[0]'
      end
    end

    subject { tgt }

    it 'should change the name attribute' do
      src.names[0] = :d
      should have_attributes(name: :d)
    end

  end

end