class Node
  attr_accessor :title
  attr_accessor :rating
  attr_accessor :left
  attr_accessor :right
  attr_accessor :parent
  attr_accessor :descendants

  def initialize(title, rating)
    @title = title
    @rating = rating
    @descendants = 0
  end

end
