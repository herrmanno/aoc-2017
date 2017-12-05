input = File.read("input.txt")
lines = input.split("\n")
lines = lines.select! { |line|
	parts = line.split(" ")
	parts.size === Set.new(parts).size
}
if !lines.nil?
	puts(lines.size)
end