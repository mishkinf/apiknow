class Route
  attr_accessor :path, :description, :http_method, :required_params, :optional_params, :test_file

  def initialize(path, description, http_method, required_params, optional_params,test_file=nil)
    @path = path
    @description = description
    @http_method = http_method
    @required_params = required_params
    @optional_params = optional_params
    @test_file = test_file
  end

  def make_query_string(params)
    return "" unless params && params.count > 0

    "?" + params.collect do |param|
      "#{param.name}=#{param.example_value}" if param.type == :query
    end.join('&')
  end

  def path_with_params(params=nil)
    params ||= required_params

    "#{@path}#{make_query_string(params)}"
  end

  def human_readable
    "#{@http_method.to_s} #{@path}"
  end
end