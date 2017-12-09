import java.io.File

var inGarbage = false
var garbageCount = 0

val reader = File("input.txt").reader()
reader.use {
    while (true) {
        val c = reader.read()
        if (c == -1) break
        
        if (!inGarbage) {
            when (c.toChar()) {
                '<' -> inGarbage = true
                '>' -> inGarbage = false
                '!' -> reader.read()
            }
        } else {
            when (c.toChar()) {
                '>' -> inGarbage = false
                '!' -> reader.read()
                else -> garbageCount++
            }
        }
    }
}

println("There are $garbageCount characters of garbage in the stream") 
