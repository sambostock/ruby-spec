require_relative '../../spec_helper'
require_relative 'shared/to_s'

describe "Method#inspect" do
  it_behaves_like :method_to_s, :inspect

  ruby_version_is '2.7' do
    it 'displays implicit parameters as underscores' do
      should_inspect 'attr=(_)'
      should_inspect 'writer=(_)'
      should_inspect 'two_grouped_defined_method(_)'
      should_inspect 'double_two_grouped_defined_method(_, _)'
    end

    it 'includes original method name when aliased' do
      should_inspect 'foo()'
      should_inspect 'bar(foo)()'
      should_inspect 'baz(foo)()'
    end

    it 'displays empty parameters as empty parens' do
      should_inspect 'foo()'
      should_inspect 'reader()'
      should_inspect 'zero()'
      should_inspect 'zero_defined_method()'
    end

    it 'displays required positional parameters as their name' do
      should_inspect 'one_req(a)'
      should_inspect 'one_req_defined_method(x)'
      should_inspect 'two_req(a, b)'
      should_inspect 'two_req_defined_method(x, y)'
      should_inspect 'single_numeric_parameter_defined_method(_1)'
      should_inspect 'double_numeric_parameter_defined_method(_1, _2)'
    end

    it 'displays optional positional parameters with an ellipsis' do
      should_inspect 'one_opt(a=...)'
      should_inspect 'one_req_one_opt(a, b=...)'
      should_inspect 'one_req_two_opt(a, b=..., c=...)'
      should_inspect 'two_req_one_opt(a, b, c=...)'
      should_inspect 'one_opt_defined_method(x=...)'
      should_inspect 'one_req_one_opt_defined_method(x, y=...)'
      should_inspect 'one_req_two_opt_defined_method(x, y=..., z=...)'
      should_inspect 'two_req_one_opt_defined_method(x, y, z=...)'
    end

    it 'displays variadic positional parameters with an asterisk' do
      should_inspect 'zero_with_splat(*a)'
      should_inspect 'one_req_with_splat(a, *b)'
      should_inspect 'two_req_with_splat(a, b, *c)'
      should_inspect 'zero_with_splat_defined_method(*x)'
      should_inspect 'one_req_with_splat_defined_method(x, *y)'
      should_inspect 'two_req_with_splat_defined_method(x, y, *z)'
    end

    it 'displays required keyword parameters with leading colon' do
      should_inspect 'zero_one_kw(a:)'
      should_inspect 'zero_one_kw_defined_method(x:)'
    end

    it 'displays optional rd parameters with leading colon and ellipsis' do
      should_inspect 'zero_one_opt_kw(a: ...)'
      should_inspect 'zero_one_kw_one_opt_kw(a:, b: ...)'
      should_inspect 'zero_one_opt_kw_defined_method(x: ...)'
      should_inspect 'zero_one_kw_one_opt_kw_defined_method(x:, y: ...)'
    end

    it 'displays variadic keyword parameters with double asterisks' do
      should_inspect 'zero_variadic_kw(**a)'
      should_inspect 'zero_one_kw_variadic_kw(a:, **b)'
      should_inspect 'zero_one_opt_kw_variadic_kw(a: ..., **b)'
      should_inspect 'zero_one_kw_one_opt_kw_variadic_kw(a:, b: ..., **c)'
      should_inspect 'zero_variadic_kw_defined_method(**x)'
      should_inspect 'zero_one_kw_variadic_kw_defined_method(x:, **y)'
      should_inspect 'zero_one_opt_kw_variadic_kw_defined_method(x: ..., **y)'
      should_inspect 'zero_one_kw_one_opt_kw_variadic_kw_defined_method(x:, y: ..., **z)'
    end

    it 'displays block parameters with ampersand' do
      should_inspect 'zero_with_block(&blk)'
      should_inspect 'zero_with_block_defined_method(&blk)'
    end

    it 'displays ignored parameters as a single asterisk' do
      should_inspect 'ignored(*)'
      should_inspect 'ignored_defined_method(*)'
    end

    it 'displays forwardable parameters as an ellipsis' do
      should_inspect 'forwardable(...)'
      # should_inspect 'forwardable_defined_method(...)' # FIXME: Not supported
    end

    it 'displays forbidden keywords as double asterisk nil' do
      should_inspect 'zero_no_kw(**nil)'
      should_inspect 'zero_no_kw_defined_method(**nil)'
    end

    it 'displays combinations of parameters correctly' do
      should_inspect 'everything(a, b, c=..., d=..., *e, f:, g:, h: ..., i: ..., **j, &blk)'
      should_inspect 'everything_no_kw(a, b=..., *c, **nil, &blk)'
    end

    def should_inspect(signature)
      method_name = signature.split('(').first
      method = MethodSpecs::Methods.new.method(method_name)

      inspect = "#<Method: MethodSpecs::Methods##{signature} #{method.source_location.join(':')}>"

      method.inspect.should == inspect
    end
  end
end
