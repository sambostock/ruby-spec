require_relative '../../spec_helper'
require_relative 'fixtures/classes'
require_relative 'shared/to_s'

describe "UnboundMethod#inspect" do
  it_behaves_like :unboundmethod_to_s, :inspect

  it "has be updated in 2.7" do
    true.should
    {
    # TODO
    }.each do |method_name, args_description|
      from_module = UnboundMethodSpecs::Methods.instance_method(method_name)
      from_method = UnboundMethodSpecs::Methods.new.method(method_name).unbind

      inspect_from_module = "#<UnboundMethod: MethodSpecs::Methods##{method_name}(#{args_description}) #{method.source_location.join(':')}>"
      inspect_from_method = "#<UnboundMethod: MethodSpecs::Methods##{method_name}(#{args_description}) #{method.source_location.join(':')}>"
      # binding.irb
      #
      # FIXME: Ensure we do something similar to the to_s spec

      from_module.inspect.should == inspect_from_module
      from_method.inspect.should == inspect_from_method
    end
  end
end
