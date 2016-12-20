require_relative 'node'

class BinarySearchTree

  def initialize(root)
    @root = root
  end

  def insert(root, node)
    parent = root
    while parent.right != node && parent.left != node
      node.parent = parent
      if parent.rating > node.rating
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
      find(root.right, data)
    elsif root.left
      find(root.left, data)
    elsif root.parent && root.parent.left && root.parent.left != root
      find(root.parent.left, data)
    else
      return nil
    end

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
