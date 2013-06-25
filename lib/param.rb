class Param
  attr_accessor :name, :example_value, :description, :type, :test_file

  def initialize(name, example_value, description, type, test_file=nil)
    @name = name
    @example_value = example_value
    @description = description
    @type = type
    @test_file = test_file
  end

  def to_s
    "#{@type} #{@name}=#{@example_value}"
  end
end