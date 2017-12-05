require "math"

# Rings:
# 2 - 9
# 10 - 25
# 26 - 49

# Ring no.      1   2   3
# Center right: 2   11  28

# betwen 1^2 and 3^2 -->    RING 1
# betwen 3^2 and 5^2 -->    RING 2

input = File.read("input.txt").to_i

ring = (Math.sqrt(input).ceil / 2).to_i

centerRight = (ring * 2 - 1) ** 2 + ring
ringCenters = (0..4).map do |i|
    centerRight + 2 * i * ring
    
end

shortestDiffToCenter = ringCenters.map { |c|
    (c - input).abs
}.min

steps = ring + shortestDiffToCenter

puts "Needed steps are #{steps}"