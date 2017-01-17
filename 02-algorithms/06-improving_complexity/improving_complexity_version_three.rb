def version_three(*arrays)
  combined_array = arrays.flatten

  sorted_array = [combined_array.delete_at(combined_array.length-1)]

  while combined_array.empty? == false
    val = combined_array[0]
    i = 0
    while i < sorted_array.length
      if val <= sorted_array[i]
        sorted_array.insert(i, val)
        combined_array.shift
        break
      elsif i == sorted_array.length - 1
        sorted_array.insert(i, val)
        combined_array.shift
        break
      end
      i+=1
    end
  end

  sorted_array
end
