#!/usr/bin/env ruby

# step one shebang line from above, step two in command line run chmod +x (file name)

require_relative 'improving_complexity_version_one.rb'
require_relative 'improving_complexity_version_two.rb'
require_relative 'improving_complexity_version_three.rb'
require 'benchmark'

def benchmarks(i)
  arryForOne = []
  arryForTwo = []
  arryForThree = []

  i.times do
    x = randArrs
    arryForOne << x.clone
    arryForTwo << x.clone
    arryForThree << x.clone
  end

  Benchmark.bm(10) do |x|
    x.report("one") do
      i.times {|j| version_one(arryForOne[j])}
    end

    x.report("two") do
      i.times {|j| version_two(arryForTwo[j])}
    end
    x.report("three") do
      i.times {|j| version_three(arryForThree[j])}
    end
  end

end


def randArrs
  number_of_arrays = Random.rand(100)
  arrs = []
  number_of_arrays.times do
    arr = []
    number_of_items = Random.rand(100)
    number_of_items.times { arr << Random.rand(100) }
    arrs << arr
  end
  arrs
end



benchmarks(100)

=begin
  results with all rands being up to 100 and benchmark being run 100 times

      user     system      total        real
    one         14.270000   0.040000  14.310000 ( 14.444239)
    two          8.890000   0.010000   8.900000 (  8.912582)
    three       14.270000   0.020000  14.290000 ( 14.300913)

=end
