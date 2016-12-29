
require_relative 'bucket_sort.rb'
require_relative 'heap_sort.rb'
require_relative 'quick_sort.rb'
require 'benchmark'

def benchmarks
  arryForQuick = randArr()
  arryForHeap = randArr()
  arryForBucket = randArr()

  puts "benchmark for quick sort"
  puts Benchmark.measure {quickSort(arryForQuick)}

  puts "benchmark for heap sort"
  puts Benchmark.measure {heapSort(arryForHeap)}

  puts "benchmark for bucket sort"
  puts Benchmark.measure {bucketSort(arryForBucket)}

end


def randArr
  arr = []
  50.times { arr << Random.rand(100) }
  arr
end

benchmarks
