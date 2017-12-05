numbers = File.read("input.txt").split("\n").map(&.to_i)
# numbers = [0, 3,  0,  1,  -3]

idx = 0
steps = 0

while
    newidx = idx + numbers[idx]
    if newidx < 0 || newidx > numbers.size() -1
        steps += 1
        break
    else
        steps += 1
        numbers[idx] +=  numbers[idx] > 2 ? -1 : 1
        idx = newidx
    end
end

puts("Needed #{steps} steps to escape list")