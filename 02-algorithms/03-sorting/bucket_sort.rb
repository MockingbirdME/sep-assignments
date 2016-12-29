def bucketSort(array, n = false)
  return array if n
  arry = array
  max = findMax(arry)
  numberOfBuckets = arry.length
  buckets = Array.new(numberOfBuckets) { [] }

  arry.length.times do |x|
    bucketNumber = ((arry[x] * numberOfBuckets) / (max + 1))
    buckets[bucketNumber] << arry[x]
  end

  returnArry = []
  buckets.each do |bkt|
    if bkt.length > 1
      bkt = bucketSort(bkt, true)
    end
    bkt.each { |item| returnArry << item  } unless bkt.empty?
  end
  returnArry
end

def findMax(array)
  max = array[0]
  array.each do |x|
    max = x if x > max
  end
  max
end
