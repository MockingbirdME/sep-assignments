class Node
  @attr_accessor name
  @attr_accessor film_actor_hash


end

def find_kevin_bacon(startNode, currentArray)
  currentArray = currentArray
  return currentArray if startNode.name == "Kevin Bacon"
  startNode.film_actor_hash.each do |film|
    film.each do |actor|
      sendingArray = currentArray << film
      find_kevin_bacon(actor, sendingArray)
    end
  end
end
