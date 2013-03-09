require_relative 'test_helper'

include Ducktape

# BindingSource.new(src, 'names[0]')

class Names
  include Bindable

  bindable :names, default: Ducktape.hookable([])
end

class SimpleBindable
  include Bindable

  bindable :name
end

describe Expression::IndexerExp do
  it 'should work' do
    src = Names.new
    src.names.push :a, :b, :c
    tgt = SimpleBindable.new

    tgt.name = BindingSource.new(src, 'names[0]')

    tgt.name.should == :a
  end
end