input = File.read("input.txt").split("\t").map(&.to_i)
# input = [0, 2, 7, 0]

states = Set(Array(Int32)).new()
states << input

steps = 1
state = input.clone

while true
	state = state.clone
	mIdx = maxIdx(state)
	blocks = state[mIdx]
	state[mIdx] = 0
	idx = mIdx
	while blocks > 0
		idx += 1
		idx %= state.size
		state[idx] += 1		
		blocks -= 1
	end

	if states.includes?(state)
		puts("Found infinite loop point after #{steps} steps")
		break
	else
		states << state
		steps += 1
	end
	
end


def maxIdx(arr)
	i = 0
	idx = 0
	max = arr[0]
	while i < arr.size
		if arr[i] > max
			idx = i
			max = arr[i]
		end
		i += 1
	end
	return idx
end