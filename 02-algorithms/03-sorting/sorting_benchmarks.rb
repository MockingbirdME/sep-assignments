
require_relative 'bucket_sort.rb'
require_relative 'heap_sort.rb'
require_relative 'quick_sort.rb'
require 'benchmark'

def benchmarks(i)
  arryForQuick = []
  arryForHeap = []
  arryForBucket = []

  i.times do
    x = randArr
    arryForQuick << x.clone
    arryForHeap << x.clone
    arryForBucket << x.clone
  end

  Benchmark.bm(10) do |x|
    x.report("quick") do
      i.times {|j| quickSort(arryForQuick[j])}
    end
    x.report("heap") do
      i.times {|j| heapSort(arryForHeap[j])}
    end
    x.report("bucket") do
      i.times {|j| bucketSort(arryForBucket[j])}
    end
  end

end


def randArr
  arr = []
  50.times { arr << Random.rand(100) }
  arr
end



benchmarks(10000)
