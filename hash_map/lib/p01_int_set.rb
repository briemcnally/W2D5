require 'byebug'
class MaxIntSet

  def initialize(max)
    @max = max
    @store = Array.new(max) {false}
  end

  def insert(num)
    validate!(num)
    # if is_valid?(num)
    @store[num] = true
    return true
    # end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num <= @max && num >= 0
    # raise "Out of bounds" if num > @max || num < 0
    # true
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end

end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].each do |n|
      return true if n == num
    end

    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !self.include?(num)
      self[num] << num
      @count += 1
    end

    if @count == num_buckets
    resize!
    end
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    return false if self[num].nil?

    self[num].each do |n|
      return true if n == num
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    store2 = Array.new(num_buckets * 2) { Array.new }

    @store.each do |bucket|
      #next if bucket.nil?

      bucket.each do |el|
        store2[el % (num_buckets * 2)] << el
      end
    end

    @store = store2
  end
end
