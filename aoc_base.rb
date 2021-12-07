class AocBase
  def initialize(filename, options = {})
    @filename = filename
    @data = File.readlines(@filename).collect(&:strip)
    @data = @data.collect(&:to_i) if options[:integers]
  end
end
