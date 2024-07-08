
class SoccerProcessor
  TYPE = :soccer

  TABLE_POSITIONS = {
    number:        0,
    team:          1,
    plays:         2,
    wins:          3,
    looses:        4,
    draws:         5,
    goals_for:     6,
    goals_against: 7,
    points:        8
  }.freeze

  def initialize(file_path)
    file_contents = File.read(file_path)
    # Grab the contents from the file inside the <pre></pre>
    match = file_contents.match(/<pre>(.*?)<\/pre>/m)
    @file_lines = match.nil? ? raise(StandardError.new("Wrong wrapper for file")) : match[1]
    # Split the file into lines to be processed ignoring headers and empty lines
    @file_lines = @file_lines.split(/\n/).reject{ |line| line.empty? }[1..-1]
    raise(StandardError.new("Empty file")) if @file_lines.empty?
  end

  def smallest_delta
    differences = @file_lines.inject([]) do |accum, line|
      scanned_line = line.scan(/[^\s-]+/)
      next accum if scanned_line.empty?

      accum << {
        number: scanned_line[TABLE_POSITIONS[:number]],
        team:   scanned_line[TABLE_POSITIONS[:team]],
        delta:  (scanned_line[TABLE_POSITIONS[:goals_for]].to_i - scanned_line[TABLE_POSITIONS[:goals_against]].to_i).abs,
      }
      accum
    end

    differences.min_by{ |entry| entry[:delta] }[:team]
  end
end
