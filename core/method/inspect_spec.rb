require_relative '../../spec_helper'
require_relative 'shared/to_s'

describe "Method#inspect" do
  it_behaves_like :method_to_s, :inspect

  it "has be updated in 2.7" do
    {
      'attr=': '_',
      'writer=': '_',
      bar: 'foo)(', # FIXME: This is an alias. Need to change helper.
      baz: 'foo)(', # FIXME: This is also an alias. Need to change helper.
      foo: '',
      method_missing: 'method, *arguments',
      no_args_defined_method: '',
      one_opt: 'a=...',
      one_opt_with_block: 'a=..., &blk',
      one_req: 'a',
      one_req_defined_method: 'x',
      one_req_one_opt: 'a, b=...',
      one_req_one_opt_with_block: 'a, b=..., &blk',
      one_req_one_opt_with_splat: 'a, b=..., *c',
      one_req_one_opt_with_splat_and_block: 'a, b=..., *c, &blk',
      one_req_two_opt: 'a, b=..., c=...',
      one_req_two_opt_with_block: 'a, b=..., c=..., &blk',
      one_req_two_opt_with_splat: 'a, b=..., c=..., *d',
      one_req_two_opt_with_splat_and_block: 'a, b=..., c=..., *d, &blk',
      one_req_with_block: 'a, &blk',
      one_req_with_splat: 'a, *b',
      one_req_with_splat_and_block: 'a, *b, &blk',
      reader: '',
      same_as_foo: '',
      two_grouped_defined_method: '_',
      two_req: 'a, b',
      two_req_defined_method: 'x, y',
      two_req_one_opt: 'a, b, c=...',
      two_req_one_opt_with_block: 'a, b, c=..., &blk',
      two_req_one_opt_with_splat: 'a, b, c=..., *d',
      two_req_one_opt_with_splat_and_block: 'a, b, c=..., *d, &blk',
      two_req_with_block: 'a, b, &blk',
      two_req_with_splat: 'a, b, *c',
      two_req_with_splat_and_block: 'a, b, *c, &blk',
      zero: '',
      zero_defined_method: '',
      zero_with_block: '&blk',
      zero_with_splat: '*a',
      zero_with_splat_and_block: '*a, &blk',
      zero_with_splat_defined_method: '*x',
    }.each do |method_name, args_description|
      method = MethodSpecs::Methods.new.method(method_name)
      inspect = "#<Method: MethodSpecs::Methods##{method_name}(#{args_description}) #{method.source_location.join(':')}>"
      # binding.irb

      method.inspect.should == inspect
    end
  end
end
