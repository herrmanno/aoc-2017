import java.io.File

// var inGroup = false
var inGarbage = false
var totalScore = 0
var currentScore = 0

val reader = File("input.txt").reader()
reader.use {

    while (true) {
        val charCode = reader.read()
        if (charCode == -1) break
        val c = charCode.toChar()
        
        when (c) {
            '{' -> {
                if (!inGarbage) {
                    currentScore++
                }
            }
            '}' -> {
                if (currentScore > 0 && !inGarbage) {
                    totalScore += currentScore
                    currentScore--
                }
            }
            '<' -> inGarbage = true
            '>' -> inGarbage = false
            '!' -> reader.read()            
        }
    }
}

println("Total score is $totalScore") 
