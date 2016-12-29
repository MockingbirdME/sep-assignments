require_relative 'quick_sort.rb'

def bucketSort(array)
  arry = array
  max = array.max
  numberOfBuckets = arry.length
  buckets = Array.new(numberOfBuckets) { [] }

  arry.length.times do |x|
    bucketNumber = ((arry[x] * numberOfBuckets) / (max + 1))
    buckets[bucketNumber] << arry[x]
  end

  returnArry = []
  buckets.each do |bkt|
    if bkt.length > 1
      bkt = quickSort(bkt)
    end
    bkt.each { |item| returnArry << item  } unless bkt.empty?
  end
  returnArry
end
