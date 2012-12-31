# map, flat_map, select, reject, grep, zip, take, take_while, drop, drop_while, cycle

class LazyEnumerator < Enumerator
  def select(&block)
    chain do |yielder, element, index|
      yielder.yield element if block.call(element)
    end
  end

  def reject(&block)
    chain do |yielder, element, index|
      yielder.yield element unless block.call(element)
    end
  end

  def map(&block)
    chain do |yielder, element, index|
      yielder.yield block.call(element)
    end
  end

  def drop(n)
    self.class.new do |yielder|
      each.with_index do |element, index|
        yielder.yield element if index >= n
      end
    end
  end

  def drop_while(&block)
    self.class.new do |yielder|
      match_found = false
      each do |element|
        match_found ||= !block.call(element)
        yielder.yield element if match_found
      end
    end
  end

  def cycle
    self.class.new do |yielder|
      loop do
        each do |element|
          yielder.yield element
        end
      end
    end
  end

  private

  def chain(&block)
    self.class.new do |yielder|
      each do |element|
        block.call yielder, element
      end
    end
  end
end

e = LazyEnumerator.new do |seq|
  n = 0
  loop do
    seq << n += 1
  end
end

p e.take(10)

p e.select {|n| n % 2 == 0}.take(10)
p e.reject {|n| n % 2 == 0}.take(10)
p
p e.map {|n| n * 3}.take(10)

p e.take_while {|n| p n;n < 3}

p e.drop(5).take(10).drop(2).take(2)

p e.drop_while {|n| n < 10}.take(10)
p e.take_while {|n| n < 10}.to_a

f = LazyEnumerator.new do |seq|
  n = 0
  while n < 10
    seq << n += 1
  end
end

p f.cycle.take(100)





def next_occurrences(n, previous_occurrence, period)
  1.upto(n).map do |n|
    previous_occurrence + (n * period)
  end
end

require 'active_support/all'

p next_occurrences(5, 1.minute.ago, 1.week)

evens = Enumerator.new do |yielder|
  n = 1
  loop do
    yielder.yield n * 2
    n = n + 1
  end
end

p evens.take(5)

p evens.include?(1_000_000)

previous_occurrence = 1.day.ago
period = 5.days
occurrences = Enumerator.new do |yielder|
  n = 1
  loop do
    yielder.yield previous_occurrence + (n * period)
    n = n + 1
  end
end

p occurrences.take(4)

p occurrences.take_while {|t| t < 1.month.from_now}

p occurrences.drop_while {|t| t < 2.weeks.from_now}.take(3)

e = Enumerator.new do |yielder|
  n = 1
  loop do
    puts "Calculating value #{n}"
    yielder.yield n
    n = n + 1
  end
end

e.take(5)

def sequence(&generator)
  Enumerator.new do |yielder|
    n = 1
    loop do
      yielder.yield generator.call(n)
      n = n + 1
    end
  end
end

sequence do |n|
  puts "Calculating value #{n}"
  n * n
end