require_relative 'node'

class BinaryHeap

  def initialize(root)
    @root = root
  end

  def insert(root, data)
    parent = root
    node = data
    while node.parent == nil
      if parent.left == nil
        parent.left = node
        node.parent = parent
      elsif parent.right == nil
        parent.right = node
        node.parent = parent
      elsif leftIsOpen(parent)
        parent = parent.left
      else
        parent = parent.right
      end
    end

    parent.descendants += 1
    while parent.parent
      parent = parent.parent
      parent.descendants += 1
    end

    while node.rating > node.parent.rating
      nodeClone = node.clone
      parent = node.parent
      grandParent = node.parent.parent
      parentClone = parent.clone
      if grandParent.left == parent
        grandParent.left = node
      else
        grandParent.right = node
      end
      if parent.left == node
        node.left = parent
        node.right = parent.right
      else
        node.right = parent
        node.left = parent.left
      end
      node.parent = parent.parent
      parent.parent = node
      parent.left = nodeClone.left
      parent.right = nodeClone.right
      parent.descendants -= 1
      node.descendants += 1
    end

  end

  def delete(root, data)
    return nil if data == nil
    node = find(root, data)
    replacement = root
    while replacement.left || replacement.right
      if replacement.right
        replacement = replacement.right
      else
        replacement = replacement.left
      end
    end

    if replacement.parent.right == replacement
      replacement.parent.right = nil
    elsif replacement.parent.left == replacement
      replacement.parent.left = nil
    end

    if node.title == replacement.title
      node = nil
    else
      replacement.parent = node.parent
      replacement.left = node.left
      replacement.right = node.right
      if node.parent.left == node
        node.parent.left = replacement
      elsif node.parent.right == node
        node.parent.right = replacement
      end
    end


  end

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

  def printf
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

  def leftIsOpen(node)
    left = node.left.descendants
    right = node.right.descendants
    var = 2
    total = 2
    while left > total
      var *= 2
      total += var
    end
    ((left == total) && (left > right)) ? false : true
  end

end
