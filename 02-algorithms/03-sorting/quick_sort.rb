def quickSort(array)
  arry = array
  pivotIndex = array.length - 1
  checkIndex = 0

  while checkIndex < pivotIndex
    if arry[checkIndex] <= arry[pivotIndex]
      checkIndex += 1
    else
      placeholder = arry[checkIndex]
      arry.slice!(checkIndex)
      arry.insert(pivotIndex, placeholder)
      pivotIndex -= 1
    end
  end

  if pivotIndex > 1
    arry[0..(pivotIndex - 1)] = quickSort(arry[0..pivotIndex - 1])
  end
  if pivotIndex < arry.length-2
    arry[(pivotIndex + 1)..-1] = quickSort(arry[(pivotIndex + 1)..-1])
  end

  return arry

end
