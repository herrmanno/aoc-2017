const fs = require("fs")

const input = +fs.readFileSync(__dirname + "/" + "input.txt").toString()

let length = 1
let idx = 1
let el = null

for (let i = 1; i <= 50000000; i++) {
	idx += input
	idx %= length
	length++
	if (idx === 0) {
		el = +i
	}
	idx = (idx + 1 % input)
}

console.log(`The element right after '0' is ${el}`)