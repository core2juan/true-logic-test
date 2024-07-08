Dir["processors/*.rb"].each {|file| require file }

class DataProcessor
  def initialize(type: :all, soccer_file: 'soccer.dat', temperature_file: 'w_data.dat')
    case type
    when :temperature
    when :soccer
    when :all
    else
      raise StandardError.new("Type not valid")
    end
  end

  private

  def validate_file(file_path)
    if File.exists?(file_path)
    else
      raise StandardError.new("File #{file_path} does not exist")
    end
  end
end
