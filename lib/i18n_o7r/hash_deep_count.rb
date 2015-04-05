class Hash

  def _deep_count(&block)
    n = 0
    self.each do |k,v|
      case v
      when Array then n += v.map(&block).inject(:+) || 0
      when Hash then n += v._deep_count(&block)
      else n += block_given? ? yield(v) : 1
      end
    end
    n
  end

end
