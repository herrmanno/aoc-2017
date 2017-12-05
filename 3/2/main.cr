class Foo

    @input : Int32 = File.read("input.txt").to_i

    @h = Hash(Tuple(Int32,Int32), Int32).new(0)

    @dirs : Array(Symbol) = [:R, :U, :L, :D]
    @dir : Int32 = 0

    @pos : Tuple(Int32,Int32) = {0, 0}

    def initialize
        @h[{0,0}] = 1
    end

    def move(pos : Tuple(Int32, Int32), dir : Symbol) : Tuple(Int32, Int32)
        case dir
        when :R
            return {pos[0] + 1, pos[1]}
        when :L
            return {pos[0] - 1, pos[1]}
        when :U
            return {pos[0], pos[1] + 1}
        when :D
            return {pos[0], pos[1] - 1}
        else
            raise "Invalid direction #{dir}"
        end
    end

    def value(pos : Tuple(Int32, Int32)) : Int32
        x, y = pos
        val = [
            @h[{x + 1, y}],
            @h[{x - 1, y}],
            @h[{x, y + 1}],
            @h[{x, y - 1}],
            @h[{x + 1, y + 1}],
            @h[{x - 1, y - 1}],
            @h[{x - 1, y + 1}],
            @h[{x + 1, y - 1}]
        ].sum

        if val > @input
            puts("First larger number than #{@input} is: #{val}")
            Process.exit(0)
        end

        return val
    end

    def func()
        i = 1
        while true
            i.times {
                @pos = move(@pos, @dirs[@dir])
                @h[@pos] = value(@pos)
            }
            @dir = (@dir + 1) % @dirs.size
            
            i.times {
                @pos = move(@pos, @dirs[@dir])
                @h[@pos] = value(@pos)
            }
            @dir = (@dir + 1) % @dirs.size
            i += 1
        end
    end

end

Foo.new().func()