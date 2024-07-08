Dir[File.join(__dir__, 'processors', '*.rb')].each { |file| require_relative file }

class DataProcessorInterface
  def initialize(type: , file_path: )
    @type = type
    @file_path = validate_file(file_path)

    # Grab all definded processors to wrap the executions and types
    processor_classes = ObjectSpace.each_object(Class).compact.select{|c| c.to_s !~ /^RSpec::/ && c.to_s.match?(/Processor$/) }
    @processors = processor_classes.inject({}) do |accum, processor_class|
      accum[processor_class.const_get(:TYPE)] = processor_class
      accum
    end

    # Validate the type of processor that needs to be executed
    raise StandardError.new("Type not valid") unless @processors.keys.include?(type)
  end

  def run
    @processors[@type].new(@file_path).smallest_delta
  end

  private

  def validate_file(file_path)
    if File.exist?(file_path)
      file_path
    else
      raise StandardError.new("File #{file_path} does not exist")
    end
  end
end
