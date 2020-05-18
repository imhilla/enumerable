# rubocop: disable Metrics/ModuleLength
# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    index = 0
    while index < size

      case self.class.name
      when 'Hash' then yield(keys[index], self[keys[index]])
      when 'Array' then yield(self[index])
      when 'Range' then yield(to_a[index])
      end
      index += 1
    end
    self
  end

  def my_each_with_index
    return to_enum :my_each_with_index unless block_given?

    index = 0
    while index < size
      yield(self[index], index)
      index += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    if is_a?(Array)
      array = []
      my_each do |num|
        array << num if yield(num)
      end
      array
    elsif is_a?(Hash)
      hash = {}
      my_each do |key, val|
        hash[key] = val if yield(key, val)
      end
      hash
    end
  end

  def my_all?(pattern = nil)
    if pattern.nil?
      if block_given?
        my_each { |value| return false unless yield(value) }
      else my_each { |value| return false unless value }
      end
    elsif pattern.is_a?(Regexp)
      my_each { |value| return false unless value.match(pattern) }
    elsif pattern.is_a?(Module)
      my_each { |value| return false unless value.is_a?(pattern) }
    else
      my_each { |value| return false unless value == pattern }
    end
    true
  end

  def my_any?(pattern = nil)
    if pattern.nil?
      if block_given?
        my_each { |value| return true if yield(value) }
      else my_each { |value| return true if value }
      end
    elsif pattern.is_a?(Regexp)
      my_each { |value| return true if value.match(pattern) }
    elsif pattern.is_a?(Module)
      my_each { |value| return true if value.is_a?(pattern) }
    else
      my_each { |value| return true if value == pattern }
    end
    false
  end

  def my_none?(pattern = nil)
    if pattern.nil?
      if block_given?
        my_each { |value| return false if yield(value) }
      else my_each { |value| return false if value }
      end
    elsif pattern.is_a?(Regexp)
      my_each { |value| return false if value.match(pattern) }
    elsif pattern.is_a?(Module)
      my_each { |value| return false if value.is_a?(pattern) }
    else
      my_each { |value| return false if value == pattern }
    end
    true
  end

  def my_count(argument = nil)
    if block_given?
      counter = 0
      my_each do |i|
        counter += 1 if yield(i)
      end
      counter
    elsif !argument.nil?
      output = my_select { |i| i == argument }
      output.size
    else
      size
    end
  end

  def my_map(a_proc = nil)
    array = []
    if a_proc.is_a?(Proc)
      my_each { |i| array.push(a_proc.call(i)) }
    elsif block_given?
      my_each { |i| array.push(yield(i)) }
    else
      return to_enum :my_map
    end
    array
  end

  def my_inject(arg1 = nil, arg2 = nil)
    to_a unless is_a?(Array)
    accumulator = nil
    operation = nil

    if arg1.is_a?(Numeric)
      accumulator = arg1
      operation = arg2 if arg2.is_a?(Symbol)
    end
    operation = arg1 if arg1.is_a?(Symbol)

    if !operation.nil?
      my_each do |element|
        accumulator = accumulator ? accumulator.send(operation, element) : element
      end
    else
      my_each do |element|
        accumulator = accumulator ? yield(accumulator, element) : element
      end
    end
    accumulator
  end
end
# rubocop: enable Metrics/ModuleLength
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
