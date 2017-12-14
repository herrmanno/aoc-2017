const fs = require("fs")

const layers = fs.readFileSync("input.txt").toString().split("\n")
.map(line => line.split(":").map(Number))

let i = 0
out: while (true) {
    for (const layer of layers) {
        const [depth, range] = layer
        if ((depth + i) % ((range - 1) * 2) === 0) {
            i++; continue out
        } 
    }

    console.log(`Firewall can be passed w/ delay of ${i} picoseconds`)
    break
}