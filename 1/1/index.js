const fs = require("fs")

const input = fs.readFileSync("input.txt").toString()

let numbers = input.split('').map(Number)
numbers = [...numbers, ...numbers.slice(-1)]

const sum = numbers.reduce((sum, n, i, arr) => {
	if (void 0 === arr[i + 1]) {
		return sum
	} else {
		return sum + (n === arr[i + 1] ? n : 0)
	}
}, 0)

console.log(`The sum is ${sum}`)
