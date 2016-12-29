def heapSort(array)
  arry = array
  sortedItems = 0

  while sortedItems < arry.length
    largestItem = arry[sortedItems]
    largestItemIndex = sortedItems
    checkIndex = sortedItems+1

    while checkIndex < arry.length
      if arry[checkIndex] > largestItem
        largestItem = arry[checkIndex]
        largestItemIndex = checkIndex
      end
      checkIndex += 1
    end
    arry.slice!(largestItemIndex)
    arry.unshift(largestItem)
    sortedItems += 1
  end

  return arry

end
