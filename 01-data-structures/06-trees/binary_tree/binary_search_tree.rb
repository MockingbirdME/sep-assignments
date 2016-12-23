require_relative 'node'

class BinarySearchTree

  def initialize(root)
    @root = root
  end

  def insert(root, node)
    parent = root

    while parent.right != node && parent.left != node
      node.parent = parent
      if parent.rating >= node.rating
        parent.left ? parent = parent.left : parent.left = node
      elsif parent.rating < node.rating
        parent.right ? parent = parent.right : parent.right = node
      end
    end

  end

  # Recursive Depth First Search
  def find(root, data)
    return root if root.title == data
    if root.right
      found = find(root.right, data)
    end
    if root.left && found.nil?
      found = find(root.left, data)
    end
     found ? found : nil
  end

  def delete(root, data)
    return nil if data == nil

    node = find(root, data)
    unless hasChildren(node)
      if hasParent(node)
        if node.parent.left == node
          node.parent.left = nil
        else
          node.parent.right = nil
        end
      end
      node = nil
      return
    end
    if node.right && node.right.left
      placeholder = node.right.left
      while placeholder.left
        placeholder = placeholder.left
      end
    end
    if placeholder.right
      placeholder.right.parent = placeholder.parent
      placeholder.parent.left = placeholder.right
    else
      placeholder.parent.left = nil
    end
    placeholder.parent = node.parent
    placeholder.left = node.left
    placeholder.right = node.right
    if @root != node
      if node.rating > node.parent.rating
        node.parent.right = placeholder
      else
        node.parent.left = placeholder
      end
    end
  end

  # Recursive Breadth First Search
  def printf(children=nil)
    toPrint = ""
    nextLine = []
    toPrint += "#{@root.title}: #{@root.rating}\n"
    nextLine << @root.left if @root.left
    nextLine << @root.right if @root.right
    while nextLine.length > 0
      placeholder = []
      nextLine.each do |x|
        title = x.title
        rating = x.rating
        toPrint += "#{title}: #{rating}\n"
        placeholder << x.left if x.left
        placeholder << x.right if x.right
      end
      nextLine = placeholder
    end
    print toPrint
  end






  private

  def hasChildren(node)
    node.right || node.left
  end

  def hasParent(node)
    node.parent
  end
end

require 'benchmark'
def benchmarks
  arry = []
  i = 1
  root = Node.new("zero", 50000)
  100000.times do
    name = "number #{i}"
    number = (Random.rand *10000000).floor + i
    var = Node.new(name, number)
    arry << var
    i += 1
  end

  puts "benchmark for adding 100000 items to binary tree"
  puts Benchmark.measure {
    tree = BinarySearchTree.new(root)
    arry.each {|node| tree.insert(root, node)}
  }
  testTree = BinarySearchTree.new(root)
  arry.each {|node| testTree.insert(root, node)}
  puts "benchmark for finding number 50000 in tree"
  puts Benchmark.measure {
    tree.find("number 50000")
  }
end
