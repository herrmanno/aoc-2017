import java.io.File

val input = File("input.txt").readText()
val instructions = input.split(",")

var x = 0
var y = 0
var max = 0

for (instr in instructions) {
    when (instr) {
        "n" -> y -= 2
        "s" -> y += 2
        "ne" -> { x += 1 ; y -= 1 }
        "nw" -> { x -= 1 ; y -= 1 }
        "se" -> { x += 1 ; y += 1 }
        "sw" -> { x -= 1 ; y += 1 }
    }
    max = Math.max(max, (Math.abs(x) + Math.abs(y)) / 2)
}


println("Distance at end: ${(Math.abs(x) + Math.abs(y)) / 2}")
println("Max distance during walk: $max")