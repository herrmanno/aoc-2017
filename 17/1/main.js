const fs = require("fs")

const input = +fs.readFileSync(__dirname + "/" + "input.txt").toString()

const buf = [0]
let idx = 1

for (let i = 1; i <= 2017; i++) {
	idx += input
	idx %= buf.length
	buf.splice(idx, 0, i)
	idx = (idx + 1 % input)
}

// console.dir(buf.slice(idx -2, idx +2))
console.log(`The element right after the last inserted element (2017) is ${buf[idx]}`)