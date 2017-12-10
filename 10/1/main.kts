import java.io.File

val lengths = File("input.txt").readText().split(",").map(Integer::parseInt)
val LIST_SIZE = 256

val list = (0..LIST_SIZE-1).toList().toMutableList()
var idx = 0
var skip = 0

for(length in lengths) {
    println("Length $length")
    println("idx: $idx, skip: $skip")
    println("list: $list")

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

println("Product of first to list elements is ${list[0] * list[1]}" )