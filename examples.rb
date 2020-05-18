
# tests
[1, 2, 3].my_each do |n|
    text = "Current number is: #{n}"
    puts text
  end
  
  a = [18, 22, 33, 3, 5, 6]
  puts "my_select method :#{a.my_select { |num| num > 10 }}\n\n"
  
  enu1 = [10, 19, 18]
  res1 = enu1.my_all? { |num| num > 4 }
  puts res1
  
  enu1 = [10, 19, 18]
  res1 = enu1.none? { |num| num > 4 }
  puts res1
  
  enu1 = [10, 19, 18]
  res1 = enu1.any? { |num| num > 4 }
  puts res1
  
  a = [18, 22, 33, nil, 5, 6]
  puts "counting : #{a.my_count}\n\n"
  
  a = [18, 22, 33, 3, 5, 6]
  puts "map method :#{a.my_map { |num| num > 10 }}\n\n"
  
  def sum(array)
    array.my_inject(0) { |sum, num| sum + num }
  end
  p sum([5, 10, 20])
  