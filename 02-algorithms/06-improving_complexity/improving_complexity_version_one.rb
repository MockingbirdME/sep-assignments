# This method takes n arrays as input and combine them in sorted ascending  order
def version_one(*arrays)
  combined_array = arrays.flatten
  sorted_array = []


  sorted_array << combined_array[0]

  (1..combined_array.length-1).each do |x|
    i = 0
    val = combined_array[x]

    while i < sorted_array.length
      if val <= sorted_array[i]
        sorted_array.insert(i, val)
        break
      elsif i == sorted_array.length - 1
        sorted_array.push(val)
        break
      end
      i+=1
    end
  end

  # Return the sorted array
  sorted_array
end
