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

function toBinaryString(s) {
    while (s.length > 8) {
        return toBinaryString(s.slice(0, s.length / 2)) + toBinaryString(s.slice(s.length / 2))
    }

    return parseInt(s, 16).toString(2).padStart(s.length * 4, "0")
}

function addToGroups(s, row, groups) {
    const bs = toBinaryString(s)
    for (let col = 0, c = bs[col]; col < bs.length; c = bs[++col]) {
        if (row === 120 && col === 33) debugger
        
        if (+c) {
            const matches = groups.filter(g => g.some(([row2, col2]) =>
                (row === row2 && Math.abs(col - col2) === 1) ||
                (col === col2 && Math.abs(row - row2) === 1)
            ))
            if (matches.length > 1) {
                while (matches.length > 1) {
                    const g = matches.pop()
                    matches[0].push(...g)
                    groups.splice(groups.indexOf(g), 1)
                }
                matches[0].push([row, col])
            } else if (matches.length === 1) {
                matches[0].push([row, col])
            } else {
                groups.push([ [row, col] ])
            }
        }
    }
}



const key = fs.readFileSync("input.txt").toString()

const groups = []
for(let i = 0; i < 128; i++) {
    const hash = knotHash(`${key}-${i}`)
    addToGroups(hash, i, groups)
}

console.log(`There are ${groups.length} distinct groups`)