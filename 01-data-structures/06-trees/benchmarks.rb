#!/usr/bin/env ruby
require './binary_tree/binary_search_tree.rb'
require './binary_heap/binary_heap.rb'
def benchmarks
  arry = []
  arry2 = []
  root = Node.new("root", 5000000)
  root2 = Node.new("root2", 100000000)
  100000.times do |i|
    name = "number #{i}"
    number = (Random.rand *10000000.0).floor
    var = Node.new(name, number)
    arry << var
  end
  100000.times do |x|
    name = "number #{x}"
    puts name if x < 3001
    number = (Random.rand *10000000.0).floor
    nodeForHeap = Node.new(name, number)
    arry2 << nodeForHeap
  end
  node3 = Node.new("number 3", 100000000-1)
  node3000 = Node.new("number 3000", 9999)
  arry2 << node3
  arry2 << node3000

  puts "benchmark for adding 100000 items to binary tree"
  tree = BinarySearchTree.new(root)

  var2 = Benchmark.measure do
    arry.each do |node|
       tree.insert(root, node)
    end
  end
  puts var2

   puts "benchmark for adding 100000 items to binary heap"
   benchmarkHeap = BinaryHeap.new(root2)
   var3 = Benchmark.measure do
     arry2.each do |node|
        benchmarkHeap.insert(root2, node)
    end
  end
  puts var3

  testTree = BinarySearchTree.new(root)
  arry.each { |node| testTree.insert(root, node) }
  testHeap = BinaryHeap.new(root2)
  arry2.each { |node| testHeap.insert(root2, node) }
  puts "benchmark for finding number 50000 in tree"
  puts Benchmark.measure {
    testTree.find(root, "number 50000")
  }
  puts "benchmark for finding number 50000 in heap"
  puts Benchmark.measure {
    testHeap.find(root2, "number 3")
  }
  puts "benchmark for deleting number 3 in tree"
  puts Benchmark.measure {
    testTree.delete(root, "number 3")
  }
  puts "benchmark for deleting number 3 in heap"
  puts Benchmark.measure {
    testHeap.delete(root2, "number 3")
  }
  puts "benchmark for deleting number 3000 in tree"
  puts Benchmark.measure {
    testTree.delete(root, "number 3000")
  }
  puts "benchmark for deleting number 3000 in heap"
  puts Benchmark.measure {
    testHeap.delete(root2, "number 3000")
  }
end

benchmarks
