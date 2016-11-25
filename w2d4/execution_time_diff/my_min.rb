list = (0..1_000).to_a.reverse

def my_min_slow(arr)

  arr.each_with_index do |el1, idx1|
    is_min = true
    arr.each_with_index  do |el2, idx2|
      next if idx1 == idx2
      is_min = false if el2 < el1
    end
    return el1 if is_min
  end

end

# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
#     p my_min_slow(list)

def my_min_fast(arr)

  min = arr.first
  arr.each do |el1|
    min = el1 if el1 < min
  end
  min
end

start_time = Time.now

  p my_min_slow(list)
  puts Time.now - start_time
start_time = Time.now

  p my_min_fast(list)
  puts Time.now - start_time


  # start_time = Time.now
  #
  # p
  #
  # puts Time.now - start_time
  #
  # start_time = Time.now
  #
  # p
  #
  # puts Time.now - start_time
