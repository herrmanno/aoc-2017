import java.io.File
import java.lang.Long.parseLong

fun knotHash(s: String, rounds: Int = 1): String {
    val lengths = s.map(Char::toInt) + listOf(17, 31, 73, 47, 23)
    val LIST_SIZE = 256

    val list = (0..LIST_SIZE-1).toList().toMutableList()
    var idx = 0
    var skip = 0


    for(roun in 1..rounds) {
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

    val hexHash = denseHash.map { Integer.toString(it, 16).padStart(2, '0') }.joinToString("")
    return hexHash
}

fun bitCount(hash: String): Int {
    val i = parseLong(hash, 16)
    val s = Long.toString(i, 2)
    return s.fold(0, { acc, c ->
        if (c == '1') return acc + 1
        else return acc
    })
}

val key = File("input.txt").readText()
val hash = knotHash(key)
val used = bitCount(hash)

println(hash)
println(used)