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
      parentPlaceholder = [node.parent.left, node.parent.right, node.parent.descendants]
      nodePlaceholder = [node.left, node.right, node.descendants]
      parent = node.parent
      if parent.parent.left == parent
        parent.parent.left = node
        node.parent = parent.parent
      elsif parent.parent.right == parent
        parent.parent.right = node
        node.parent = parent.parent
      end
      parent.parent = node
      parent.left = nodePlaceholder[0]
      parent.right = nodePlaceholder[1]
      parent.descendants = nodePlaceholder[2]
      if parentPlaceholder[0].title == node.title
        node.left = parent
        node.right = parentPlaceholder[1]
      elsif parentPlaceholder[1].title == node.title
        node.right = parent
        node.left = parentPlaceholder[0]
      end
      node.descendants = parentPlaceholder[2]
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
        replacement = replace.left
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
      node.title = replacement.title
      node.rating = replacement.rating
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

  def print(root)

  end

  private

  def leftIsOpen(node)
    left = node.left.descendants
    right = node.right.descendants
    var = 2
    while left > var
      var *= 2
    end
    left == var && left > right ? false : true
  end

end
