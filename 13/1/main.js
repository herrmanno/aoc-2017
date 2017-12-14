const fs = require("fs")

const sev = fs.readFileSync("input.txt").toString().split("\n")
.map(line => line.split(":").map(Number))
.reduce((sev, [depth, range]) => {
    if (depth % ((range - 1) * 2) === 0) {
        return sev + depth * range
    } else {
        return sev
    }
}, 0)


console.log(`Severity is ${sev}`)