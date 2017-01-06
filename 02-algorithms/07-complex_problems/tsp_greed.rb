def travelingSalesmanViaNearestNeighbor(city_list, starting_city, route = [], total_distance = 0, remaining_cities = [])

  loopCompleted = false
  currentRoute = route
  currentDistance = total_distance
  if remaining_cities.empty? && route.empty?
    remainingCities = city_list.cityNames
  else
    remainingCities = remaining_cities
  end


  until starting_city.visited
    neighborCities = current_city.neighbors
    nextCity = nil

    for neighbor in neighborCities
      if remainingCities.empty?
        if neighbor[:name] == currentRoute[0]
          nextCity = neighbor
          loopCompleted = true
        end
      elsif remainingCities.includes?(neighbor[:name])
        nextCity = neighbor unless nextCity
        nextCity = neighbor if neighbor[:distance] < nextCity[:distance]
      end
    end

    if nextCity
      currentRoute << nextCity[:name]
      currentDistance += nextCity[:distance]
      remainingCities.delete_if { |x| x == nextCity[:name] }
      nextCity = city_list.getCity(nextCity[:name])
    else
      currentRoute << "loop could not be completed with this city_list and starting_city"
      loopCompleted = true
    end
    current_city.visited = true
  end
  unless loopCompleted
    travelingSalesmanViaNearestNeighbor(city_list, nextCity, currentRoute, currentDistance, remainingCities)
  end
  finalLoop = {route: currentRoute, distance: currentDistance}
end


class City
  attr_accessor :name
  attr_accessor :neighbors
  attr_accessor :visited

  def initialize(name, *adjacent_cities)
    @name = name
    @neighbors = []
    adjacent_cities.each {|city| neighbors << city}
  end
end

class CityList
  attr_accessor :cityNames

  def initialize(cities_for_list)
    @cityNames = []
    @cities = []
    cities.each do |city|
      @cityNames << city.name
      @cities << city
    end
  end

  def getCity(city_name)

  end

end


portland = City.new("Portland", {name: "Falmouth", distance: 10}, {name: "Westbrook", distance: 8}, {name: "South Portland", distance: 6}, {name: "Scarborough", distance: 11} )

falmouth = City.new("Falmouth", {name: "Portland", distance: 10}, {name: "Westbrook", distance: 9}, {name: "South Portland", distance: 15}, {name: "Scarborough", distance: 12} )

westbrook = City.new("Westbrook", {name: "Falmouth", distance: 9}, {name: "Portland", distance: 8}, {name: "South Portland", distance: 7}, {name: "Scarborough", distance: 12 } )

south_portland = City.new("South Portland", {name: "Falmouth", distance: 15}, {name: "Westbrook", distance: 7}, {name: "Portland", distance: 6}, {name: "Scarborough", distance: 5} )

scarborough = City.new("Scarborough", {name: "Westbrook", distance: 12}, {name: "Falmouth", distance: 12}, {name: "South Portland", distance: 5}, {name: "Portland", distance: 11})
