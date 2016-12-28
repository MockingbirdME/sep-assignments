
def recursiveBinarySearch(array, value)
  low = 0
  high = array.length-1
  low <= high ? mid = (low + high)/2 : return "#{value} not found"
  if array[mid] == value
    return mid
  elsif array[mid] < value
    recursiveBinarySearch(array[(mid+1)..-1], value)
  else
    recursiveBinarySearch(array[0..(mid+1)], value)
  end
end
