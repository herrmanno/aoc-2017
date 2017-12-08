input = File.read("input.txt")

class Instr
	@reg : String
	@inc : String
	@val : Int32
	@cond : String

	def initialize(s)
		m = /(\w+) (\w+) (-?\d+) (.*)/.match(s)
		raise "Bad line #{s}" if m.nil?
		@reg = m[1]
		@inc = m[2]
		@val = m[3].to_i
		@cond = m[4]
	end

	def exec(r : Hash(String,Int32))
		m = /if (\w+) (\S*) (-?\d+)/.match(@cond)
		raise "Bad condition" if m.nil?

		name = m[1]
		regVal = r[name]
		op = m[2]
		val = m[3].to_i

		t = false
		case op
			when ">" then t = regVal > val
			when "<" then t = regVal < val
			when ">=" then t = regVal >= val
			when "<=" then t = regVal <= val
			when "==" then t = regVal == val
			when "!=" then t = regVal != val
		else raise "Bad op"
		end

		
		if t
			case @inc
				when "inc" then r[@reg] = r[@reg] + @val
				when "dec" then r[@reg] = r[@reg] - @val
				else raise "Bad inc/dec"
			end
		end
	end

end

instructions = input.split("\n").map { |line| Instr.new(line) }

reg = Hash(String,Int32).new(0)

highest = 0

instructions.map do |instr|
	instr.exec(reg)
	if reg.values.size > 0
		highest = [highest, reg.values.max].max
	end
end

puts("Highegt value ever held in any register during processing is #{highest}")