
class TemperatureProcessor
  TYPE = :temperature

  TABLE_POSITIONS = {
    'Dy':     0,
    'MxT':    1,
    'MnT':    2,
    'AvT':    3,
    'HDDay':  4,
    'AvDP':   5,
    '1HrP':   6,
    'TPcpn':  7,
    'WxType': 8,
    'PDir':   9,
    'AvSp':   10,
    'Dir':    11,
    'MxS':    12,
    'SkyC':   13,
    'MxR':    14,
    'MnR':    15,
    'AvSLP':  16,
  }.freeze

  def initialize(file_path)
    file_contents = File.read(file_path)
    # Grab the contents from the file inside the <pre></pre>
    match = file_contents.match(/<pre>(.*?)<\/pre>/m)
    @file_lines = match.nil? ? raise(StandardError.new("Wrong wrapper for file")) : match[1]
    # Split the file into lines to be processed ignoring title headers and empty lines
    @file_lines = @file_lines.split(/\n/).reject{ |line| line.empty? }[2..-1]
    raise(StandardError.new("Empty file")) if @file_lines.empty?
  end

  def smallest_delta
    differences = @file_lines.inject([]) do |accum, line|
      scanned_line = line.scan(/\s+(\d+)\s+(\d+)\*?\s+(\d+)\*?\s+(\d+)\s+(\s|\d+)\s+(\d+(?:\.\d+)?)\s+(\s|\d+)\s+(\d+(?:\.\d+)?)\s+(\s|\w+)\s+(\d+)\s+(\d+(?:\.\d+)?)\s+(\d+)\s+(\d+)\*?\s+(\d+(?:\.\d+)?)\s+(\d+)\s+(\d+)\s+(\d+(?:\.\d+)?)/).flatten
      next accum if scanned_line.empty?

      accum << {
        day_number: scanned_line[TABLE_POSITIONS[:Dy]],
        delta:  (scanned_line[TABLE_POSITIONS[:MxT]].to_i - scanned_line[TABLE_POSITIONS[:MnT]].to_i).abs,
      }
      accum
    end

    differences.min_by{ |entry| entry[:delta] }[:day_number]
  end
end
