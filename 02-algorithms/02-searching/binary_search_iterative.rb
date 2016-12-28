
def iterativeBinarySearch(array, value)
  low = 0
  high = array.length-1
  while low <= high
    mid = (low + high)/2
    if array[mid] == value
      return mid
    elsif array[mid] < value
      low = mid + 1
    else
      high = mid - 1
    end
  end
  return "#{value} not found"
end
