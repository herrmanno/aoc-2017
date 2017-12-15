import java.io.File

val lengths = File("input.txt").readText().map(Char::toInt) + listOf(17, 31, 73, 47, 23)
val LIST_SIZE = 256

val list = (0..LIST_SIZE-1).toList().toMutableList()
var idx = 0
var skip = 0


for(roun in 1..64) {
    for(length in lengths) {

        if (length > LIST_SIZE) {
            continue
        }

        val copy = mutableListOf<Int>()

        for(index in 0..length-1) {
            copy.add(0, list[(idx + index) % LIST_SIZE ])
        }

        for((index, value) in copy.withIndex()) {
            list[(idx + index) % LIST_SIZE] = value
        }

        idx += length + skip
        idx %= LIST_SIZE
        skip++
    }
}

val sparseHash = list
val denseHash = mutableListOf<Int>()
for(i in 0..15) {
    var h = 0
    for(j in 0..15) {
        h = h.xor(sparseHash[i * 16 + j])
    }
    denseHash.add(h)
}

val hexHash = denseHash.map { it.toString(16).padStart(2, '0') }.joinToString("")

println("hex: $hexHash")