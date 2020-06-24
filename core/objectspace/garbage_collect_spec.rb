require_relative '../../spec_helper'

describe "ObjectSpace.garbage_collect" do

  it "can be invoked without any exceptions" do
    ObjectSpace.garbage_collect
  end

  it "doesn't accept any arguments" do
    -> { ObjectSpace.garbage_collect(1) }.should raise_error(ArgumentError)
  end

  it "ignores the supplied block" do
    ObjectSpace.garbage_collect {}
  end

  it "always returns nil" do
    ObjectSpace.garbage_collect.should == nil
    ObjectSpace.garbage_collect.should == nil
  end

end
