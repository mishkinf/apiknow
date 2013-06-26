class Module
  def virtual(*methods)
    methods.each do |m|
      define_method(m) {
        raise VirtualMethodCalledError, m
      }
    end
  end
end

class Document
  attr_reader :resources
  virtual :generate

  def initialize(resources)
    @resources = resources
  end

  def save(file_path)
    File.open(file_path, 'w') do |f|
      f.write(generate)
    end
    puts "#{file_path} generated."
  end
end

class VirtualMethodCalledError < RuntimeError
  attr :name
  def initialize(name)
    super("Virtual function '#{name}' called")
    @name = name
  end
end
