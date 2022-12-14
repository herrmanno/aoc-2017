const fs = require("fs")

function knotHash(s, rounds = 64) {
    const LIST_SIZE = 256
    const lengths = [...s.split("").map(c => c.charCodeAt(0)), 17, 31, 73, 47, 23]

    const list = Array.apply(null, { length: LIST_SIZE }).map(Number.call, Number)
    let idx = 0
    let skip = 0


    for (let r = 0; r < rounds; r++) {
        for(length of lengths) {

            if (length > LIST_SIZE) {
                continue
            }

            const copy = []

            for (let index = 0; index < length; index++) {
                copy.unshift(list[(idx + index) % LIST_SIZE ])
            }

            copy.forEach((value, index) => {
                list[(idx + index) % LIST_SIZE] = value
            })

            idx += length + skip
            idx %= LIST_SIZE
            skip++
        }
    }

    const sparseHash = list
    const denseHash = []
    for(i = 0; i < 16; i++) {
        let h = 0
        for(j = 0; j < 16; j++) {
            h ^= sparseHash[i * 16 + j]
        }
        denseHash.push(h)
    }

    const hexHash = denseHash.map(it => it.toString(16)).map(s => `0${s}`.slice(-2)).join("")
    return hexHash
}

function bitCount(s) {
    while (s.length > 8) {
        return bitCount(s.slice(0, s.length / 2)) + bitCount(s.slice(s.length / 2))
    }

    return parseInt(s, 16).toString(2).split("").reduce((acc, bit) => acc + (bit === '1'), 0)
}


const key = fs.readFileSync("input.txt").toString()

let sum = 0
for(let i = 0; i < 128; i++) {
    const hash = knotHash(`${key}-${i}`)
    sum += bitCount(hash)
}

console.log(`There are ${sum} used squres`)