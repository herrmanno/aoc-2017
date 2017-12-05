input = File.read("input.txt")
lines = input.split("\n")
lines = lines.select! { |line|
	parts = line.split(" ")
	parts = parts.map { |part|
		part.chars.sort.join("")
	}
	parts.size === Set.new(parts).size
}
if !lines.nil?
	puts(lines.size)
end