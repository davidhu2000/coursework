list = [2, 3, -6, 7, -6, 7]
list = (1..100).to_a.shuffle

def sub_sum_slow(list)

  subsets = []
  (0...list.length).each do |i|
    subset = [list[i]]
    subsets << subset
    (i+1...list.length).each do |j|
      subset << list[j]
      subsets << subset
    end
  end

  subsets.map { |subset| subset.inject(&:+) }.max

end

def sub_sum_fast(list)
  max_sum = list.first
  current_sum = list.first
  list.each_with_index do |el, idx|
    next if idx.zero?
    current_sum += el
    max_sum = current_sum if current_sum > max_sum
    if el > max_sum
      max_sum = el
      current_sum = el
    end
  end
  max_sum
end


start_time = Time.now

p sub_sum_slow(list)
puts Time.now - start_time
start_time = Time.now

p sub_sum_fast(list)
puts Time.now - start_time
