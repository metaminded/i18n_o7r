class Hash

  def _deep_count(&block)
    n = 0
    self.each do |k,v|
      case v
      when Array
        n += block_given? ? v.map(&block).inject(:+) || 0 : v.length
      when Hash then n += v._deep_count(&block)
      else n += block_given? ? yield(v) : 1
      end
    end
    n
  end

end
